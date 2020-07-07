function [fa, fb, f] = hinhthangmorong()
fx = @(x) x^2 + x + 1;
a = 2;
b = 3;
n = 5;

h = (b - a )/n;

fa = fx(a);
fb = fx(b);
fh =  0;

i = 1;

while i < n
    fh = fh + 2*fx(a + i*h);
    i = i + 1;
end
f = h/2 * (fa + fh + fb);
end
