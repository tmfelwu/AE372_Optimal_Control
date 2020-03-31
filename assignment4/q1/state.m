function X_k1 = state(X_k, U_k)

global dt
x1_k = X_k(1) ; x2_k = X_k(2); x3_k = X_k(3);

x1_k1 = x1_k + dt*(U_k/0.001 - x1_k/0.2 - x2_k/0.01 - x1_k*x2_k/0.1);
x2_k1 = x2_k + dt*(x3_k);
x3_k1 = x3_k + dt*(- (x1_k^2)/200 - x1_k/10 - x2_k - 0.5*x3_k - 0.5 - 0.5 + 1);
X_k1 = [x1_k1;x2_k1;x3_k1];

