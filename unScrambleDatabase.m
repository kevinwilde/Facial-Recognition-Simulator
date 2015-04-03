function [newDatabase,indices] = unScrambleDatabase(imagePath,database)
% UNSCRAMBLEDATABASE reorders the columns of the image database so each
% column corresponds to the correct student name
% 1 -> StudentName1
% 2 -> StudentName2
% 3 -> StudentName3
% ...

% Inputs: 
%          imagePath   : Folder under which the images have been saved
%          database    : Image database
% Outputs:
%          newDatabase : Reordered database
%          indices     : indices for reordering

indices = zeros(1,size(database,2));
newDatabase = zeros(size(database));

% You have to write this part of code for this function to run properly

for ii=1:434
    imageName = strcat(imagePath, 'student',num2str(ii),'.png');
    image_ii = readImage(imageName); %
    indices(ii) =  findMinimumErrorPosition(image_ii,database);
    newDatabase(:,ii) = database(:,indices(ii));
end
end