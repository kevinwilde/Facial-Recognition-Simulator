function y = reconstructImage(img,dictionary,blockSize)

if size(dictionary,1) < blockSize(1) || size(dictionary,1) < blockSize(2)
    error('Dictionary size not consistent with block size.')
end

% Use nd2col() to convert each image block of size blockSize to a column and store all these columns in a matrix
blocks = nd2col(img, blockSize, 'sliding');

reconstructedPatches = zeros(size(blocks));
for jj = 1:size(blocks,2)
    LSsolution = solveModifiedLS(dictionary,blocks(:,jj));
    reconstructedPatches(:,jj) = reconstructPatch(dictionary,LSsolution);
end

y = col2nd(reconstructedPatches,blockSize,size(img),'sliding');
y = makeVector(y);
end

