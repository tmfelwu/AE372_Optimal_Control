% integrate y_dot = y for y(0) = 1

%% Test 1 Scalar function
% t0, tf, step size, inital_condition, function
func = @(t,y) y;
[t,y]= rk4(0,1,0.1,1,func);

%% Test 2 Multivariable function
func = @(t,y) [y(1) y(2)]';
[t,y]= rk4(0,1,0.1,[1 1],func);