Y = @(x) cos(x);
h1 = 0.1;
h2 = 0.01;
h3 = 0.001;
f1 = @(x) (sin(x + h1) - sin(x))/h1;
f2 = @(x) (sin(x + h2) - sin(x))/h2;
f3 = @(x) (sin(x + h3) - sin(x))/h3;

h4 = 0.01;
ftt = @(x) (sin(x + h4) - sin(x - h4))/(2*h4);
fplot(Y, [0 2]);
hold on;
fplot(f1, [0 2]);
hold on;
fplot(f2, [0 2]);
hold on;
fplot(f3, [0 2]);
hold on;
fplot(ftt, [0 2]);