%% Q2
A = [0  1 ; -1 -2 ];
syms t
A^100
exp(A*t)
svd(A)

%% Q3
syms a1 a2 a3 a4 l
A = [-a1 -a2 -a3 -a4; 1 0 0 0 ; 0 1 0 0; 0 0 1 0];
eval(det(A - l * eye(4)))


%% Q4
x = -10:1:10;
y = x;
[X, Y]  = meshgrid(x,y);
Z= 2*X.^3 + 6 * X .* Y.^2 - 3 * Y.^3 - 150 * X;
figure
surf(X,Y,Z)
colorbar
figure
levels = [ 2000:-100:500 500:-50:-200 -200:-30:-500 -500:-100:-2000];
contour(X,Y,Z,levels)
colorbar

%% Q5
A = [ 1 1 2 1; 1 -2 0 -1 ];
b = [1 -2]';
minimizer = A'* inv( A* A') * b

%% Q6
