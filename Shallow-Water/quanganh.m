lat = 21.0278;
long = 105.8342;
%f = coriolisf(lat,long);
f=0.0001;
g=9.8;
L=5;
t=0;
T=4;
hx=1;hy=1;ht=1;
nx = L / hx;ny = L / hy;

%{
Ucurrent=zeroes(nx,ny);FU;
Vcurrent=zeroes(nx,ny);FV;
Hcurrent=zeroes(nx,ny);FH;
%}
H = ones(nx,ny); % displacement matrix (this is what gets drawn)
U = zeros(nx,ny); % x velocity
V = zeros(nx,ny); % y velocity

%Kh?i t?o gi� tr? ban ??u
H0 = 20000;H1=4400;H2=2660;
D=4400000;Y0 = 6*hx;Y=j*hy;
for i=1:nx
    for j=1:ny
        X=i;
        Y=j*hy;
        H(i,j)=H0+H1*tand(9*(Y-Y0)*pi/180/(2*D))+H2*sind(2*pi*X) /(cosd((9*Y-Y0)*pi/180/D)^2);
        H(i,j) = H(i,j)/10000;
    end
end
%{
i=1:nx-1
j=1:ny-1
        V(i,j) = ((H(i, j+1) - H(i, j)) / hx) * (-1/f);
        U(i,j) = ((H(i+1,j) - H(i,j)) / hy) * (-1/f);
%}
for i=1:nx-1
    for j=1:ny-1
        V(i,j) = ((H(i, j+1) - H(i, j)) / hx) * (-1/f);
        U(i,j) = ((H(i+1,j) - H(i,j)) / hy) * (-1/f);
    end
end

%{
[x,y] = meshgrid( linspace(-3,3,10) );
R = sqrt(x.^2 + y.^2) + eps;
Z = 1*(sin(R)./R);
Z = max(Z,0);
% add displacement to the height matrix
w = size(Z,1);
i = 10:w+9;
j = 20:w+19;
H(i,j) = H(i,j) + Z;
%}
% draw the mesh


grid = surf(H)
%axis([0 nx 0 ny 0 6]);
colorbar;
set(gcf, 'Position', get(0, 'Screensize'));
hold all;


%{
disp('Step 3');
[Ux,Uy,Vx,Vy,Hx,Hy] = discretization(U,V,H,hx,hy)
    %T�ch h?p theo th?i gian
[FU,FV,FH] = delta(U,V,H,Ux,Uy,Vx,Vy,Hx,Hy)
U=U+FU.*ht
V=V+FV.*ht
H=H+FH.*ht
%}
steps=1;
while t <= T
    set(grid, 'zdata', H);
    drawnow
    msg = sprintf('Step %d\n',steps)
    %Dieu kien bien
    %{
    H(nx,:) = H(1,:);
    H(:,ny) = 0;
    U(nx,:) = U(1,:);
    U(:,ny) = 0;
    V(nx,:) = V(1,:);
    V(:,ny) = 0;
    %}
    %R?i r?c h�a theo kh�ng gian
    [Ux,Uy,Vx,Vy,Hx,Hy] = discretization(U,V,H,hx,hy)

    %T�ch h?p theo th?i gian
    [FU,FV,FH] = delta(U,V,H,Ux,Uy,Vx,Vy,Hx,Hy)
    %C?p nh?t gi� tr?
    U=U+FU.*ht
    V=V+FV.*ht
    H=H+FH.*ht
    %T?ng b??c th?i gian  
    t = t+ht; 
    steps = steps+1;
end

