function [] = Phuongphapdaycung()

a = 0;
c = 1;
fx = @(x) x^3 + x - 1;
e = 0.1;

saisothucte = e + 1;
disp(['   a', '    b', '   c','   fa', '   fb', '  fc']);
while abs(saisothucte)>e
  fa = feval(fx, a);
  fc = feval(fx,c);
  b = (a*fc - c*fa)/(fc - fa);
  fb = feval(fx, b);
  saisothucte = b - a;
  disp([a,b,c,fa,fb,fc, saisothucte]);
  if fa*fb<=0
      c = b;
  else
      a = b;
  end
  
end
end