function [reconstructedImages,PSNRs] = ...
    reconstructStudentImages(corruptedImages,dictionary,blockSize,origImage)

[~,pivots] = rref(dictionary);
indep_dictionary = dictionary(:,pivots);
indep_dictionary = [ones(size(indep_dictionary,1),1) indep_dictionary];

reconstructedImages = zeros(size(corruptedImages));

for jj = 1:size(corruptedImages,2)
    corruptedImg = makeMatrix(corruptedImages(:,jj),size(origImage));
    reconstructedImages(:,jj) = reconstructImage(corruptedImg,indep_dictionary,blockSize);
end

PSNRs = computePSNRs(makeVector(origImage),reconstructedImages);

end