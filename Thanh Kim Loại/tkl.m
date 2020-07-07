


function [T, dT] = tkl()
% Khoi tao T ban dau
D = 0.1;
Time = 1;
M=20;
dt = 0.01;
dx = 0.1;
  T = [];
  u = [];
  for i=0:M
      T = [T, 25]
  end
  nTime = Time/dt;
  for t = 1:nTime
      [dT] = dhb2(M, T, D, dx);
      for i=1:M
         T(i) = T(i) + dt*(dT(i));
         disp("o vi tri " + i + "T la: " + T(i));
      end
  end
  plot(T);
end

function [dT] = dhb2(M, T, D, dx)
  c = 0;
  dT = [];
  % M = M * (1/dx);
  for i=1:M
      c = T(i);
      if i==1; l = 100;
      else l = T(i-1);
      end
      if i == M; r = 25;
      else r = T(i+1);
      end
      v = D*(l-2*c+r)/(dx*dx);
      dT = [dT, v];
  end
end