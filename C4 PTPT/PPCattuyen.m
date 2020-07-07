function [] = PPCattuyen()

fx = @(x) 2*x^3 + 4*x -3;
x0 = 0;
x1 = 1;
e = 0.1;


disp(['  x0', '  x1', '   f0','   f1', '   s', '   t', '   sai so']);
t = 0;
saiso = 100;

while saiso >= e
    f0 = feval(fx, x0);
    f1 = feval(fx, x1);
    S = x1 - f1 * (x1-x0)/(f1-f0);
    saiso = abs(feval(fx,x0));
    disp([x0, x1, f0, f1, S, t, saiso]);
    x0 = S;
    t = t+1;
end
end