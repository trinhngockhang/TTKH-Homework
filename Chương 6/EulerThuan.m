function [X] = EulerThuan(dh, t0, y0, h, t)
X = [y0];
Y = [y0];
   for i = t
       if(i == t0) A = y0;
       else 
       temp = dh(A,i);
       A = A + h*temp;
       X = [X, A];
       hold on;
       end
   end
   for i = t
       if(i == t0) C = y0; D = y0;
       else 
       temp = dh(C, i);
       C = C + h*temp;
       D = C + h*(temp + D)/2 
       Y = [Y, D];
       hold on;
       end
   end
   plot(X, t);
   plot(Y, t);
   y=@(t) 5*exp(-20.*t)+(7/19.5)*(exp(-0.5.*t)-exp(-20.*t));
   plot(y(t), t);
   legend("Euler", "Rounge Kute", "Data");
end

function [A] = RungeKutta(dh, t0, y0, h, t)
  
end

