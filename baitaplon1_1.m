function [A, Y] = baitaplon1_1()
    X = [0 0.25 0.5 1 2 3 4 5 6 8 10];
    Y = [2.5 3.6 5.3 9.5 14.0 16.5 18.8 21.5 23.2 26.8 28.4];
    p1 = polyfit(X, Y, 1);
    A = polyval(p1, X);
    plot(X, Y);
    hold on;
    plot(X, A);
    hold off;
end