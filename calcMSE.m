function [MSE] = calcMSE(x1, x2)

if numel(x1) ~= numel(x2)
    error('Vectors must be same size')
end

sumofdiffs = 0;
for ii = 1:numel(x1)
    sumofdiffs = sumofdiffs + ((x1(ii)-x2(ii)) ^ 2);
end
MSE =  sumofdiffs / numel(x1);

end

