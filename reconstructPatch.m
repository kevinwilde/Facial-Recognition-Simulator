function y = reconstructPatch(A,x)

if size(A,2) ~= size(x,1)
    error('Dimensions of A and x must be consistent')
end

y=A*x;
end

