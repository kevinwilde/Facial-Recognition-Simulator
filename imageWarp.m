function unwarpedImage = imageWarp(img, warpStartPoint, warpEndPoint)

[R, C] = size(img);
UL = [1; 1];
LL = [R; 1];
UR = [1; C];
LR = [R; C];

t1before = [UL LL warpStartPoint];
t2before = [UL UR warpStartPoint];
t3before = [LL LR warpStartPoint];
t4before = [UR LR warpStartPoint];

t1after = [UL LL warpEndPoint];
t2after = [UL UR warpEndPoint];
t3after = [LL LR warpEndPoint];
t4after = [UR LR warpEndPoint];

[mask, ~, ~] = createMask(R, C, warpEndPoint);
A1 = solveWarp(t1before, t1after);
A2 = solveWarp(t2before, t2after);
A3 = solveWarp(t3before, t3after);
A4 = solveWarp(t4before, t4after);        


unwarpedImage = zeros(R,C);
for ii = 1:R
    for jj = 1:C
        if mask(ii,jj) == 1
            [s,e] = transformCoordinates(A1, ii, jj, R, C);
            unwarpedImage(e) = img(s);
        elseif mask(ii,jj) == 2
            [s,e] = transformCoordinates(A2, ii, jj, R, C);
            unwarpedImage(e) = img(s);
        elseif mask(ii,jj) == 3
            [s,e] = transformCoordinates(A3, ii, jj, R, C);
            unwarpedImage(e) = img(s);
        elseif mask(ii,jj) == 4
            [s,e] = transformCoordinates(A4, ii, jj, R, C);
            unwarpedImage(e) = img(s);
        end
    end
end

end

