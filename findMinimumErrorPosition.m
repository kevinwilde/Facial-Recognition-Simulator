function [minPos] = findMinimumErrorPosition(imgVec, imageDatabase)

MSEs = zeros(1, size(imageDatabase,2));
for col = 1:size(imageDatabase, 2)
    MSEs(col) = calcMSE(imgVec, imageDatabase(:,col));
end
[~,minPos]=min(MSEs);

end

