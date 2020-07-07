box_size = 1;
n = 100;

dx = box_size/n;
dy = box_size/n;


u = zeros(n,n);
v = zeros(n,n);

h = ones(n,n);
h(70:80,70:80) = 1.1;
mesh(h);
title('init value');
input('Enter to start');

g = 10;
f = 0.0001;

dt = 0.01;
time = 0;

[dh_dt, du_dt, dv_dt] = d_dt(h,u,v,g,dx,dy);

while time < dt*100
    
    h = h + dh_dt * dt;
    u = u + du_dt * dt;
    v = v + dv_dt * dt;
    mesh(h);
    title(['t = ', num2str(time)])
    pause(0.1);
    time = time + dt;
end