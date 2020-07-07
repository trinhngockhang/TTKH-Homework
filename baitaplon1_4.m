function [p1, A, res, sumErr] = baitaplon1_4(order)
    X = [0 0.25 0.5 1 2 3 4 5 6 8 10];
    Y = [2.5 3.6 5.3 9.5 14.0 16.5 18.8 21.5 23.2 26.8 28.4];
    Z = [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21];
    p1 = polyfit(X, Y, order);
    A = polyval(p1, Z);
  
  
    plot(Z, A);
   
end