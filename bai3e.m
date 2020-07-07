w = 0;
z = [12  ;   2  ;  18  ;  40];
[r, c] = size(z);
for i=1: r
    for j=1: c
    w = w + z(i,j);
    end
end