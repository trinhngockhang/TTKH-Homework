% ham tinh vi phan thepo x y, su dung phuong phap sai phan thuan% dieu kien bien tuan hoan theo x% dieu kien bien co dinh theo y 
function [dx dy] = get_differential_2D(f,hx,hy) 
X = size(f,1);
Y = size(f,2);  
dx = zeros(size(f)); 
dy = zeros(size(f));  
for i=1:X    
    for j=1:Y    
        if i==X        
            dx(i,j) = (f(1,j) - f(i,j)) / hx;      
        else
            dx(i,j) = (f(i+1,j) - f(i,j)) / hx;      
        end       
        if j==Y        
            dy(i,j) = 0; 
        else
            dy(i,j) = (f(i,j+1) - f(i,j)) / hy;     
        end
    end
end
