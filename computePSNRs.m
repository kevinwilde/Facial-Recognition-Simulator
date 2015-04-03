function [PSNRs] = computePSNRs(imgVec, imageDatabase)

PSNRs = zeros(1, size(imageDatabase,2));
for col = 1:size(imageDatabase,2)
    PSNRs(col) = calcPSNR(imgVec, imageDatabase(:,col));
end
end

