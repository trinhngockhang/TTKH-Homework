S = 0;
x = @(n) ((-1)^(n+1))/(2*n-1);
for i=1:100
    S = S + x(i)
end
    