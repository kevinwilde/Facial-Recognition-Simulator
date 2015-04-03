function [vecOut] = makeVector(matrixIn)

if ~isnumeric(matrixIn)
    error('Input matrix must be a numeric matrix')
end

if ndims(matrixIn) > 2
    error('Input matrix cannot have more than two dimesions')
end
vecOut = matrixIn(:);
end
