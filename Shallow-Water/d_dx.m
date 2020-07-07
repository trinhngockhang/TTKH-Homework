function [dfx] = d_dx(f,dx)
    dfx = zeros(size(f));
    [X, Y] = size(f);
    for i=1:size(f,1)
        for j=1:size(f,2)
            if i==1
                dfx(i,j) = (f(i+1,j) - f(X,j)) / 2 / dx;
            elseif i==X
                dfx(i,j) = (f(1,j) - f(i-1,j)) / 2 / dx;
            else
            dfx(i,j) = (f(i+1,j) - f(i-1,j)) / 2 / dx;
            end
        end
    end
end