% Lab Project
%
% Student Group: Samantha Letscher, Kevin Wilde
% Image ID: 326, 383
% Section:  20
% Date:     11/10/2014

% **************************
% LAB PROJECT - INTRODUCTION
% **************************
%% Initialization
clear; close all; clc

imagePath = ['.', filesep(), 'Student_Images', filesep()];

studentNumber = 326; % You should use your personal ID after you
                    % identify your image in the Student_Images folder

studentImage = [imagePath, 'student', num2str(studentNumber), '.png'];
if ~exist(studentImage,'file')
    error('Query image does not exist... Please select a studentNumber between 1 and 434.');
end

%% Create and Unscramble Image Database

if ~exist('imageDatabases.mat','file')
    
    % Create Scrambled Image Database
    fprintf(2,'Constructing Image Database...\n');
    scrambledDatabase = createImageDatabase(imagePath);
    fprintf('Done!\n\n');
    
    % Unscramble the Database
    fprintf(2,'Unscrambling the Image Database...\n');
    [correctDatabase,scrambledIndices] = unScrambleDatabase(imagePath,scrambledDatabase);
    fprintf('Done!\n\n');
    
    % Verify that the Database has been Unscrambled
    fprintf(2,'Verifying that the Image Database is corrected...\n');
    [~,correctIndices] = unScrambleDatabase(imagePath,correctDatabase);
    if exist('calcMSE','file')
        if calcMSE(correctIndices,1:length(correctIndices)) == 0
            % If database has been corrected store the results so you don't
            % have to rerun the unscrambling code every time.
            save('imageDatabases.mat','scrambledDatabase','correctDatabase','scrambledIndices','correctIndices');
            warningFlag = false;
            fprintf('Done!\n\n');
        else
            warningFlag = true;
            warning('Image Database was not properly unscrambled');
            fprintf('\n');
        end
    else
        warning('Successful unscrambling cannot be currently evaluated... Create "calcMSE" function first');
        fprintf('\n');
    end
else
    fprintf(2,'Correct Database is already stored in a file... Loading...\n');
    scrambledDatabase  = load('imageDatabases.mat','scrambledDatabase');
    scrambledDatabase  = scrambledDatabase.scrambledDatabase;
    correctDatabase    = load('imageDatabases.mat','correctDatabase');
    correctDatabase    = correctDatabase.correctDatabase;
    scrambledIndices   = load('imageDatabases.mat','scrambledIndices');
    scrambledIndices   = scrambledIndices.scrambledIndices;
    correctIndices     = load('imageDatabases.mat','correctIndices');
    correctIndices     = correctIndices.correctIndices;
    fprintf('Done!\n\n');
end


% If unScrambling was performed correctly show the indices before and after
% unScrambling
if exist('plotIndices','file')
    plotIndices(scrambledIndices,correctIndices)
else
    warning('Indices cannot be currently plotted... Create "plotIndices" function first.');
    fprintf('\n');
end


%% Checking if you can identify yourself in the database

% Read Image to be Found (will work only after you create the readImage
% function
if exist('readImage','file')
    x = readImage(studentImage);
else
    x = [];
end

% First check your identity using the scrambled database
fprintf(2,'Checking Student Identity in the Scrambled Database...\n'); pause(0.2);
if exist('findMinimumErrorPosition','file') && exist('computePSNRs','file')
    identificationFlag = true;
    minPos = findMinimumErrorPosition(makeVector(x),scrambledDatabase);
    PSNRs  = computePSNRs(makeVector(x),scrambledDatabase);
else
    identificationFlag = false;
end

if identificationFlag
    studentName = identifyStudent(x,imagePath,minPos,PSNRs);
    fprintf('Student identified as %s at the Scrambled Database column: %d!\n\n', studentName, minPos);
    pause(0.2);
else
    warning('Students cannot be currently identified in the Scrambled Database... Create "findMinimumErrorPosition" and "computePSNRs" functions first.');
    fprintf('\n');
end

% Then check your identity again using the correct database
fprintf(2,'Checking Student Identity in the Corrected Database...\n'); pause(0.2);
if exist('findMinimumErrorPosition','file') && exist('computePSNRs','file')
    identificationFlag = true;
    minPos = findMinimumErrorPosition(makeVector(x),correctDatabase);
    PSNRs  = computePSNRs(makeVector(x),correctDatabase);
else
    identificationFlag = false;
end

if identificationFlag
    studentName = identifyStudent(x,imagePath,minPos,PSNRs);
    fprintf('Student identified as %s at the Corrected Database column: %d!\n\n', studentName, minPos);
    pause(0.2);
else
    warning('Students cannot be currently identified in the Corrected Database... Create "findMinimumErrorPosition" and "computePSNRs" functions first.');
    fprintf('\n');
end


% **************************************
% LAB PROJECT - PART 1 - TRANSFORMATIONS
% **************************************

numTransform = 8;


fprintf(2,'Transforming student image %d times...\n', numTransform);
if ~isempty(x)
    [transformedStudentImages,warpPoints] = transformStudentImage(x,studentNumber,numTransform);
    fprintf('Done!\n\n');
else
    warning('Student image is empty... read it first by creating the "readImage" function".');
    fprintf('\n');
end

fprintf(2,'Unwarping each warped student image...\n');
if exist('unwarpTransformedImagesToCenter','file')
    unwarpedStudentImages = unwarpTransformedImagesToCenter(transformedStudentImages,warpPoints,size(x));
    fprintf('Done!\n\n');
else
    warning('Images cannot be currently unwarped... create "unwarpTransformedImagesToCenter" function first');
    fprintf('\n');
end

fprintf(2,'Associating warped images with database images...\n');
if exist('associateImagesWithDatabase','file')
    transformedMinPos = associateImagesWithDatabase(transformedStudentImages,correctDatabase);
    fprintf('Done!\n\n');
else
    warning('Warped images cannot be currently associated with database... create "associateImagesWithDatabase" function first');
    fprintf('\n');
end

fprintf(2,'Associating unwarped images with database images...\n');
if exist('associateImagesWithDatabase','file')
    identificationFlag = true;
    unwarpedMinPos = associateImagesWithDatabase(unwarpedStudentImages,correctDatabase);
    fprintf('Done!\n\n');
else
    identificationFlag = false;
    warning('Unwarped images cannot be currently associated with database... create "associateImagesWithDatabase" function first');
    fprintf('\n');
end

fprintf(2,'Checking student identity for each unwarped image...\n');
if identificationFlag == true
    identifyImages(imagePath,transformedStudentImages,unwarpedStudentImages,transformedMinPos,unwarpedMinPos,size(x));
    fprintf('Done!\n\n');
else
    warning('All images cannot be currently identified... create "unwarpTransformedImagesToCenter" and "associateImageWithDatabase" functions first.');
    fprintf('\n');
end


% ************************************
% LAB PROJECT - PART 2 - LEAST SQUARES
% ************************************

%% Corrupt and Reconstruct Student Image

corruptionPercentages = 0.2:0.1:0.9;

fprintf(2,'Corrupting student image %d times...\n', numel(corruptionPercentages));
corruptedStudentImages = corruptStudentImage(x,studentNumber,corruptionPercentages);
fprintf('Done!\n\n');

dictionaryData = load('DictionaryData.mat');
dictionary = dictionaryData.DictionaryData.dictionary;
blockSize = dictionaryData.DictionaryData.blockSize;

fprintf(2,'Reconstructing student images using patch dictionary...\n');
if exist('reconstructStudentImages','file')
    [reconstructedStudentImages,reconstructionPSNRs] = reconstructStudentImages(corruptedStudentImages,dictionary,blockSize,x);
    fprintf('Done!\n\n');
else
    warning('Corrupted images cannot be currently reconstructed... create "reconstructStudentImages" function first.');
    fprintf('\n');
end

fprintf(2,'Plotting reconstruction PSNRs...\n');
if exist('reconstructionPSNRs','var')
    figure, bar(corruptionPercentages,reconstructionPSNRs);
    title('Reconstruction Performance under Image Corruption');
    xlabel('Percentage of Corrupted Pixels');
    ylabel('Peak Signal to Noise Ratio (PSNR)');
    fprintf('Done!\n\n');
else
    warning('Reconstruction PSNRs cannot be currently plotted... create "reconstructStudentImages" function first');
end

%% Checking if you can identify yourself in the database

fprintf(2,'Associating corrupted images with database images...\n');
if exist('corruptedStudentImages','var') && exist('associateImagesWithDatabase','file')
    corruptedMinPos = associateImagesWithDatabase(corruptedStudentImages,correctDatabase);
    fprintf('Done!\n\n');
else
    warning('Corrupted images cannot be currently associated with database... create "associateImagesWithDatabase" function first');
    fprintf('\n');
end

fprintf(2,'Associating reconstructed images with database images...\n');
if exist('reconstructedStudentImages','var') && exist('associateImagesWithDatabase','file')
    identificationFlag = true;
    reconstructedMinPos = associateImagesWithDatabase(reconstructedStudentImages,correctDatabase);
    fprintf('Done!\n\n');
else
    identificationFlag = false;
    warning('Reconstructed images cannot be currently associated with database... create "associateImagesWithDatabase" function first');
    fprintf('\n');
end

fprintf(2,'Checking student identity for each reconstructed image...\n');
if identificationFlag == true
    identifyImages2(imagePath,corruptedStudentImages,reconstructedStudentImages,corruptedMinPos,reconstructedMinPos,size(x));
    fprintf('Done!\n\n');
else
    warning('All images cannot be currently identified... create "reconstructStudentImages" and "associateImagesWithDatabase" functions first.');
    fprintf('\n');
end