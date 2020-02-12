% integrate y_dot = y for y(0) = 1

%% Test 1 Scalar function
% t0, tf, step size, inital_condition, function
func = @(t,y) y;
[t,y]= rk4(0,1,0.1,1,func);

%% Test 2 Multivariable function
func = @(t,y) [y(1) y(2)]';
[t,y]= rk4(0,1,0.1,[1 1],func);
plot(t,y(:,1))
hold on
[t, y] = ode45( @(t,y) func(t,y), [0:0.1:1], [1 1]);
plot(t,y(:,1),'r--')

%% Verify Backward Integration
func = @(t,y) [y(1) y(2)]';
[t,y]= rk4(1,0,-0.1,[2.7134 2.7134],func);
figure
plot(t,y(:,1))
hold on
[t, y] = ode45( @(t,y) func(t,y), [1:-0.1:0], [2.7134 2.7134]);
plot(t,y(:,1),'r--')