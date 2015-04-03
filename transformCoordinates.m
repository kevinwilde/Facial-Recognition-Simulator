function [startCoor, endCoor] = transformCoordinates(A, rEndCoor, cEndCoor, R, C)

endCoor = [];
endCoor(1,:) = rEndCoor';
endCoor(2,:) = cEndCoor';
endCoor(3,:) = ones(1, size(rEndCoor,2));

startCoor = round(A*endCoor);

for ii = 1:size(startCoor,2)
    if startCoor(1,ii) > R
        startCoor(1,ii) = R;
    elseif startCoor(1,ii) < 1
        startCoor(1,ii) = 1;
    end
    
    if startCoor(2,ii) > C
        startCoor(2,ii) = C;
    elseif startCoor(2,ii) < 1
        startCoor(2,ii) = 1;
    end
end

startCoor = sub2ind([R,C], startCoor(1,:), startCoor(2,:));
endCoor = sub2ind([R,C], endCoor(1,:), endCoor(2,:));
end

