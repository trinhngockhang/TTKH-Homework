clc;
clear;
% constant
g = 10.0;
f = 0.0001;
% init value for U V H and its differential
D = 4400000;
L = D;
hx = 628571.4/10;
hy = hx; % dx dy
x = 0:hx:L;
x = x./L;
y = 0:hy:L;
H0 = 20000;
H1 = 4400;
H2 = 2660;

y0 = 6*hx;
H = zeros(size(x,2),size(y,2));

for i=1:size(x,2)
    for j=1:size(y,2)    
     Y = j*hx;
     X = i*hx/L;
     H(i,j) = H0 + H1*tanh(9*(Y - 6)/(2*D)) + H2*sin(2*pi*X)/(cosh(9*Y-6/D)*cosh(9*Y-6/D));  
%     if(i>30 && i< 50 && j>30 && j <50)
%         H(i,j) = 10;
%     end
    end
end

U = zeros(size(H));
V = zeros(size(H));

ht = 300;
t = 0;
T = ht * 100;
% run initialization init% main algorithm
FU = zeros(size(U));
FV = zeros(size(V));
FH = zeros(size(H));
%init FU FV FH at start time
% mesh(H);
while t<T
    % break;
    figure(1);
    mesh(H);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

    title(['t = ' num2str(t)]);  
    % spatial discretization    
    [dHx, dHy] = get_differential_2D(H,hx,hy); 
    [dUx, dUy] = get_differential_2D(dHx,hx,hy);
    [dVx, dVy] = get_differential_2D(dHy,hx,hy); 
    
    % time intergration  
    %FU = -g*dHx;
    %FV = -g*dHy;
     FU = f*V - U.*dUx - V.*dUy - g*dHx; 
     FV = -f*U - U.*dVx - V.*dVy - g*dHy; 
     FH = -U.*dHx - H.*dUx - V.*dHy - H.*dVy;
    
%      FU =  - U.*dUx - V.*dUy - g*dHx; 
%      FV =  - U.*dVx - V.*dVy - g*dHy; 
%      FH =  - U.*dHx - H.*dUx - V.*dHy - H.*dVy;
     
%     FU = - g*dHx; 
%     FV = - g*dHy; 
%     FH = - H.*dUx - H.*dVy;
    
    % update value  
    U = U + FU*ht; 
    V = V + FV*ht;
    H = H + FH*ht; 
    
%     H(:,1) = zeros(1,size(H,1));
%     H(:,size(H,1)) = HH0;

    % time step t
    t = t + ht;
    pause(0.1);
end
