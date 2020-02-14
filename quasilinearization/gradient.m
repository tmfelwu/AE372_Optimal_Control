% Same question done using gradient descent 
gradtime = 0:0.01:1;
rtime = 1:-0.01:0;
ut = gradtime;
% Step  1 Assume the control history
u = ut * 0 + 1;

for j=1:100
% Step 2 Integrate the state equation forward
% x_dot = -x + u 
% x(0) = 4

[xt, x] = ode45( @(t,x) forward(t,x,ut,u), gradtime, 10 );

% Just for verification
% plot(t,x)
% hold on
% plot(t, 3 * exp(-t) + 1, 'r--')

% Step 3 Find final conditions and backward integrate the costate equation
l1 = 0;
[lt,l] = ode45(@(t,l) backward(t,l,xt,x), rtime, l1);

% Just for verification
%plot(t,l)
%hold on
%plot(t, 2* exp(-1) * ( 3 * exp(-1) + 1) * exp(t), 'r--')

% Step 4 Verify if the control equation is satisfied
dHdu = u + flip(l)';
tau = 0.09;
u = u - tau * dHdu;
end

x_grad = x;
lmabda_grad = l;
function dx = forward(t,x,ut,u)
u = interp1(ut,u,t);
dx = -x^2 + u;
end

function dl = backward(t,l,xt,x)
x = interp1(xt,x,t);
dl = -x + 2 *l * x;
end