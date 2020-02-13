time = [0:0.01:1]';
% Step 1 Assume the inital trajectories;
[m,~] = size(time);
states = zeros(m,2);

num_iteration = 10;
state_history = zeros(m,2, num_iteration);
state_hisotry(:,:,1) = states;

x0 = 10;
pf = 0;

for j=1:100  
   % Step 2 Solve the leanerized system homogeneous system with
   % x(t_0) = 0 and p(t_0) = 1
   ic_h = [0 1];
   h = ode4(@(t,y) homogeneous(t,y,time, state_history(:,:,j)), time, ic_h);
   
   % Step 3 Solve the system for particular integral
   ic_p = [10 0];
   p = ode4(@(t,y) particular(t,y,time,  state_history(:,:,j)), time, ic_p);
   
   % Step 4 Satisfy the boundary conditions
   p_h_ = h(:,2); 
   p_p_ = p(:,2);
   k = (pf - p_p_(end))/ p_h_(end);
   
   state_history(:,:,j+1) = [ k*h(:,1) + p(:,1), k*h(:,2) + p(:,2)];
   plot(time, -state_history(:,2,j+1));
   hold on
end


function dz = homogeneous(t, z,time, x)
    x_ = interp1(time,x(:,1),t);
    lambda = interp1(time,x(:,2),t);
    dz(1,1) = -2 * x_ * z(1) - 1 * z(2);  
    dz(2,1) = (-1 + 2 * lambda)* z(1) + (2 * x_) * z(2);
end

function dz = particular(t, z,time, x)
    x_ = interp1(time,x(:,1),t);
    lambda = interp1(time,x(:,2),t);
    dz(1,1) = -2 * x_ * z(1) - 1 * z(2) + (x_^2);  
    dz(2,1) = (-1 + 2 * lambda)* z(1) + (2 * x_) * z(2) - 2* x_* lambda;
end