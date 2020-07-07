clear;
clc;

M = 20;
Time = 1;
dt = 0.01; 
dx = 0.1;
D = 0.1;

T = ones(M).*25;
dT = zeros(M);

for t=1:Time/dt
  
  for i=1:M
    c = T(i);
    if (i==1)
      l = 100;
    else 
      l = T(i-1);
    end
    
    if (i==M)
      r = 25;
    else
      r = T(i+1);
    end
   
    dT(i) = D * (l-2*c+r)/(dx*dx);  
  end;
  
  for i=1:M
         T(i) = T(i) + dt*(dT(i));
  end
  
end;
