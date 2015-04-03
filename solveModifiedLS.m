function x = solveModifiedLS(A,y)

y = makeVector(y);

if size(A,1) ~= size(y,1)
    error('Dimensions must be consistent to find least-squares solution')
end

x = A(y~=0,:)\y(y~=0);

end

