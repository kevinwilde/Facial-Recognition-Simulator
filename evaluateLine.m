function y = evaluateLine(x,point1,point2)

slope_intercept = [point1(1) 1; point2(1) 1]\[point1(2); point2(2)];

y = slope_intercept(1) * x + slope_intercept(2);

end

