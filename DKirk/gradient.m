%   DKirk 6.2 An illustrative example

time = 0:0.1:1;
rtime = 1:-0.1:0;
ut = time;

%% Step  1 Assume the control history
u = ut * 0 + 1;

%% Step 2 Integrate the state equation forward
% x_dot = -x + u 
% x(0) = 4

[t, x] = ode45( @(t,x) forward(t,x,ut,u), time, 4 );

% Just for verification
% plot(t,x)
% hold on
% plot(t, 3 * exp(-t) + 1, 'r--')

%% Step 3 Find final conditions and backward integrate the costate equation
l1 = 2 * interp1(t,x,1);
[t,l] = ode45(@(t,l) backward(t,l), rtime, l1);

% Just for verification
plot(t,l)
hold on
plot(t, 2* exp(-1) * ( 3 * exp(-1) + 1) * exp(t), 'r--')

%% Step 4 Verify if the control equation is satisfied

dHdu = u + l

function dx = forward(t,x,ut,u)
u = interp1(ut,u,t);
dx = -x + u;
end

function dl = backward(t,l)
dl = l;
end