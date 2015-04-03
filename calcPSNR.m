function [PSNR] = calcPSNR(x1,x2,maxX)

if nargin < 3
    maxX = 1;
end

PSNR = 10*log10(maxX/calcMSE(x1,x2));

end

