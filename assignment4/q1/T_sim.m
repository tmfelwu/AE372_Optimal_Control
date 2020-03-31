% This is the Time Simulation
% ===========================

clear all, clc;

for k = 1:2

	figure(k)
  	clf;
end


global Q R dt

consts;

% load T_sim_pre;   % Activate the appropriate file
load T_sim_inf;

% Weights from the Networks
% =========================

W1C = net_C.IW{1,1};	b1C = net_C.b{1};
W2C = net_C.LW{2,1};	b2C = net_C.b{2};
W3C = net_C.LW{3,2};	b3C = net_C.b{3};
W4C = net_C.LW{4,3};	b4C = net_C.b{4};

x_net(:,1) = [-0.15; 0; -1];
% x_cl(:,1) = x_net(:,1);

t0 = 0;
tf = 25;

N = floor((tf-t0)/dt) + 1;
t(1) = t0;

k_disp = 1;

for (k = 1:N-1)
	
	if ( k == k_disp )
		
		k_disp = k_disp + 100;
	end
	
	% Results from the Network
	% ========================
	
	L_net(:,k+1) = net_sim(x_net(:,k),  W1C,b1C,f1C, W2C,b2C,f2C, ...
                                        W3C,b3C,f3C, W4C,b4C,f4C);
	u_net(:,k)  = opt_control(L_net(:,k+1));	
	x_net(:,k+1) = state(x_net(:,k), u_net(:,k));
    z_net(:,k) = x_net(:,k) + [10; 0.5; 0];
	t(k+1) = t(k) + dt;
    k = k + 1;
end

tu = t(1:N-1);
x_net_u = x_net(:,1:N-1);

% Plotting
% ========
figure(1);
plot(t, x_net);
hold on; grid on;
xlabel('time');
ylabel('Error_States');
figure(2);
plot(tu, u_net);
hold on; grid on;
xlabel('time');
ylabel('Control');
