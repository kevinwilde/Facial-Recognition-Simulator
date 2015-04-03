function [mask, rows, columns] = createMask(R,C,warpPoint)

if warpPoint(1) >= R || warpPoint(2) >= C
    error('Warp Point must be within image')
end
UL = [1; 1];
LL = [R; 1];
UR = [1; C];
LR = [R; C];
mask = zeros(R,C);
rows = zeros(1,R*C);
columns = zeros(1,R*C);
count = 0;
for ii = 1:R
    for jj = 1:C
        if jj <= evaluateLine(ii, UL, warpPoint) && jj <= evaluateLine(ii, LL, warpPoint)
            %Region 1
            mask(ii,jj)=1;
        elseif jj >= evaluateLine(ii, UL, warpPoint) && jj <= evaluateLine(ii, UR, warpPoint)
            %Region 2
            mask(ii,jj)=2;
        elseif jj >= evaluateLine(ii, LL, warpPoint) && jj <= evaluateLine(ii, LR, warpPoint)
            %Region 3
            mask(ii,jj)=3;
        elseif jj >= evaluateLine(ii, UR, warpPoint) && jj >= evaluateLine(ii, LR, warpPoint)
            %Region 4
            mask(ii,jj)=4;
        end
        count = count + 1;
        rows(count) = ii;
        columns(count) = jj;
    end
end

end

