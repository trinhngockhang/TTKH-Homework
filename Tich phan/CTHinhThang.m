H = @(x) (x+3)^3/(x-4)^7;
I = @(x) 1/(2*x^2 + 5*x +2);
a = 0;
b = 1;

h = H(a) + ((H(b) - H(a)) )* (b-a)/2;
i = I(a) +  ((I(b) - I(a)) )* (b-a)/2;