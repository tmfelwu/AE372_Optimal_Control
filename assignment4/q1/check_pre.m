% Weights from the Networks
% ========================= 

W1C = net_C.IW{1,1};	b1C = net_C.b{1};
W2C = net_C.LW{2,1};	b2C = net_C.b{2};
W3C = net_C.LW{3,2};	b3C = net_C.b{3};
W4C = net_C.LW{4,3};	b4C = net_C.b{4};
 
% Generation of Actual Targets
% ============================

for (k = 1:validpts)
	
	L1c_a(:,k) = net_sim(xc(:,k), 	W1C,b1C,f1C, W2C,b2C,f2C, ...
					W3C,b3C,f3C, W4C,b4C,f4C);
	L2c_a(:,k) = net_sim(x1c(:,k),	W1C,b1C,f1C, W2C,b2C,f2C, ...
					W3C,b3C,f3C, W4C,b4C,f4C);
end

% Error Calculation
% =================

err_C(m,1) = norm(L1c_a - L1c_st) / norm(L1c_st);
err_C(m,2) = norm(L2c_a - L2c_st) / norm(L2c_st);

disp('err_C =  '), disp(err_C);
disp('m =  '), disp(m);
