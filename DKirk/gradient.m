%   DKirk 6.2 An illustrative example

t = 0:0.1:1;

%% Step  1 Assume the control history
u(1:length(t)) = 1;

%% Step 2 Integrate the state equation forward
% x_dot = -x + u 
% x(0) = 4

[t, x] = ode45( @(t,x) -x + 1, [0:0.1:1], 4 );

% Just for verification
%plot(t,x)
%hold on
%plot(t, 3 * exp(-t) + 1, 'r--')

