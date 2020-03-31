function L_k = costate(L_k1, X_k)

global dt Qw 
x1_k = X_k(1) ; x2_k = X_k(2); x3_k = X_k(3);
l1_k1 = L_k1(1); l2_k1 = L_k1(2); l3_k1 = L_k1(3); 

% costate_mat = [(1-dt/0.2-dt*x2_k*0.1)*l1_k1+dt*(-x1_k/100-1/10)*l3_k1;
%                         dt*(-1/0.01-x1_k/0.1)*l1_k1 +1*l2_k1-dt*l3_k1;
%                         dt*l2_k1+(1-0.5*dt)*l3_k1];
% L_k = costate_mat+dt*Qw*X_k;
l1_k = (1-dt/0.2-dt*x2_k/0.1)*l1_k1+dt*(-x1_k/100-1/10)*l3_k1 + dt*x1_k;
l2_k = dt*(-1/0.01-x1_k/0.1)*l1_k1 +1*l2_k1-dt*l3_k1 + dt*x2_k;
l3_k = dt*l2_k1+(1-0.5*dt)*l3_k1 + dt*x3_k;

L_k = [l1_k;
          l2_k;
          l3_k];


