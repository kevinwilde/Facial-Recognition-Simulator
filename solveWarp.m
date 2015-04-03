function A = solveWarp(TStart,TEnd)

TEnd(3,:) = ones(1,3);

A = TStart * inv(TEnd);

end

