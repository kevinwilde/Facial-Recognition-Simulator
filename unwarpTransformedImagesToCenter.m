function unwarpedStudentImages = ...
    unwarpTransformedImagesToCenter(transformedStudentImages,warpPoints,imgSize)

unwarpedStudentImages = zeros(size(transformedStudentImages));

for jj = 1:size(transformedStudentImages, 2)
    % create image of size imgSize using makeMatrix()
    img = makeMatrix(transformedStudentImages(:,jj),imgSize);
    
    % unwarp image using imageWarp()
    % start point = corresponding point in warpPoints matrix
    % end point = center
    warpEndPoint = [ceil((size(img,1)+0.5)/2); ceil((size(img,2)+0.5)/2)]; %center
    unwarpedImg = imageWarp(img, warpPoints(:,jj), warpEndPoint);
    
    % vectorize unwarped image
    % place in corresponding column of unwarpedStudentImages
    unwarpedStudentImages(:,jj) = makeVector(unwarpedImg);
end
end

