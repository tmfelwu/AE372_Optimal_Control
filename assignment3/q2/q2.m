%% Compute Solution

% Initialize
A0=1;
theta=1;
A_x=@(x)-x^2;
g=1;
Q=[1];
R=[1];
[X,K,L]=icare(A0,g,Q,R,[],1);
A=A0-X;

% Define Ds and Ts
D1=@(x,t)0.98*exp(-2*t)*(2*X*x^2/theta);
T1=@(x,t)(2*X*x^2/theta-D1(x,t))/(2*A);
D2=@(x,t)0.98*exp(-0.9*t)*(2*T1(x,t)*x^2/theta+T1(x,t)*T1(x,t));
T2=@(x,t)(2*T1(x,t)*x^2/theta+T1(x,t)*T1(x,t)-D2(x,t))/(2*A);
f=@(x,t)(-(X*x+T1(x,t)*x+T2(x,t)*x));
dx=@(x,t)(x-x^3+f(x,t));
dt = 0.01;
t=0:dt:5;
t=t';

J=zeros(length(t),1);
u=J;x=J;XOpt=J;
XOpt(1)=10;
u_opt = @(x,t)-(x-x^3) - x*sqrt(x^4 - 2*x^2 + 2);
x(1)=10;
u(1)=f(x(1),t(1));
J(1)=0.5*(x(1)^2+u(1)^2)*0.005;
J_opt=zeros(length(t),1);
dx_opt=@(x,t)(x-x^3+u_opt(x,t));
UOpt=zeros(length(t),1);
UOpt(1)=u_opt(XOpt(1),t(1));
J_opt(1)=0.5*(XOpt(1)^2+UOpt(1)^2)*0.005;

for i=1:length(t)-1
    k1=0.01*dx(x(i),t(i)+0.5*0.01);
    k2=0.01*dx(x(i)+0.5*k1,t(i)+0.5*0.01);
    k3=0.01*dx(x(i)+0.5*k2,t(i)+0.5*0.01);
    k4=0.01*dx(x(i)+k3,t(i)+0.01);
    x(i+1)=x(i)+(1/6)*(k1+2*k2+2*k3+k4);
    u(i+1)=f(x(i+1),t(i+1));
    J(i+1)=(0.5*(x(i+1)^2+u(i+1)^2)*0.005+J(i));
end

for i=1:length(t)-1
    k1=0.01*dx_opt(XOpt(i),t(i)+0.5*0.01);
    k2=0.01*dx_opt(XOpt(i)+0.5*k1,t(i)+0.5*0.01);
    k3=0.01*dx_opt(XOpt(i)+0.5*k2,t(i)+0.5*0.01);
    k4=0.01*dx_opt(XOpt(i)+k3,t(i)+0.01);
    XOpt(i+1)=XOpt(i)+(1/6)*(k1+2*k2+2*k3+k4);
    UOpt(i+1)=u_opt(x(i+1),t(i+1));
    J_opt(i+1)=(0.5*(XOpt(i+1)^2+UOpt(i+1)^2)*0.005+J(i));
end

%% Plotting
% State vs time
plot(t,x);
hold on
plot(t,XOpt)
hold off
legend('$\theta$-D','optimal','interpreter','latex')
title('State vs time')
xlabel('time(second)')
ylabel('x')

% Control vs time
figure
plot(t,u);
hold on
plot(t,UOpt)
legend('$\theta-D$','optimal','interpreter', 'latex')
title('Control vs time')
axis([0 5 -5 1])
xlabel('time (second)')
ylabel('Control u')
hold off

% Cost vs time
figure
plot(t,J);
hold on
plot(t,J_opt)
legend('$\theta-D$','optimal', 'interpreter', 'latex')
title('Cost vs time')
axis([0 6 0 6])
xlabel('time (second)')
ylabel('Cost')
hold off

