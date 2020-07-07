function [] = Newton()

x0 = 2.4 ;
e = 0.01;
fx = @(x) 2*x^3 -3*x^2-5*x+1;
diff = @(x) 6*x^2 -6*x-5;
disp(['   Buoc','   x0','   f phay', '   f', '   check']);
t = 1;
saiso = 1;
while  saiso >= e
    fx0 = feval(fx, x0);
    fphayx0 = feval(diff, x0);
    check = x0 - (fx0/fphayx0);
    saiso = abs(feval(fx,x0)); 
    disp([t,x0, fphayx0, fx0, check]);
    x0 = check;
    
    t = t+1;
end
end