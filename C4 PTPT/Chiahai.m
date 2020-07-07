
function [] = aaaaa()

fx =@(x) exp(x) - 2;
a = 0;
c = 2;
e = 0.01;
time = 1;
saisothucte = e + 1;
disp(['     t' , '     a', '    b', '   c','   fa', '   fb', '  fc']);
while abs(saisothucte)>e
  b = (a+c)/2;
  fa = feval(fx, a);
  fb = feval(fx, b);
  fc = feval(fx,c);
  
  disp([time, a,b,c,fa,fb,fc])
  
  
  if fa*fb<=0
      c = b;
  else
      a = b;
  end
  saisothucte = feval(fx, b);
  time = time + 1;
end
end