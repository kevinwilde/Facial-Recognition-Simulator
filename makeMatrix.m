function [matrixOut] = makeMatrix(vecIn, matrixSize)

if ~isnumeric(vecIn)
    error('Input vector must be a numeric vector')
end

if isvector(vecIn)
    vecIn = makeVector(vecIn);
end

matrixOut = reshape(vecIn, matrixSize(1), matrixSize(2));

end

