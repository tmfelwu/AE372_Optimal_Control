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
levels = [ 2000:-100:500 500:-50:-200 -200:-50:-500 -500:-100:-2000];
contour(X,Y,Z,levels)
colorbar

%% Q5
A = [ 1 1 2 1; 1 -2 0 -1 ];
b = [1 -2]';
minimizer = A'* inv( A* A') * b
 
%% Q5 alternate
A = [
2 0 0 0 1 1;
0 2 0 0 1 -2;
0 0 2 0 2 0;
0 0 0 2 1 -1;
1 1 2 1 0 0 ;
1 -2 0 -1 0 0;
];

b = [0 0 0 0 1 -2 ]';
A\b
%% Q6
x = [-5:0.1:5];
y = x;
[X,Y] = meshgrid(x,y);
Z = X.^2 + Y.^2;
Ellipse = X.^2 + 2 * Y.^2 - 1;
contour(X,Y,Z,20)
colorbar
hold on 
contour(X,Y,Ellipse,[0 0],'r--')
grid on
pbaspect([1 1 1])

%% Q7
x = [-100:1:100];
y = x;
[X,Y] = meshgrid(x,y);
Z = (X-1).^2 + Y -2;
Line = Y - X - 1;
contour(X,Y,Z,20)
colorbar
hold on 
contour(X,Y,Line,[0 0],'r--')
Inequality = X + Y - 2;
contour(X,Y, Inequality, [-100:0.1:0])
grid on
pbaspect([1 1 1])