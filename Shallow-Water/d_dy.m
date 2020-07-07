function [dfy] = d_dy(f, dy)
    dfy = zeros(size(f));
    [X, Y] = size(f);
    for i=1:size(f,1)
        for j=1:size(f,2)
            if j==1
                dfy(i,j) = (f(i,j+1) - f(i,Y)) / 2 / dy;
            elseif j==Y
                dfy(i,j) = (f(i,1) - f(i,j-1)) / 2 / dy;
            else
            dfy(i,j) = (f(i,j+1) - f(i,j-1)) / 2 / dy;
            end
        end
    end
end