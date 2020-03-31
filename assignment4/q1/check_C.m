% Weights from the Network
% ======================== 

W1C = net_C.IW{1,1};	b1C = net_C.b{1};
W2C = net_C.LW{2,1};	b2C = net_C.b{2};
W3C = net_C.LW{3,2};	b3C = net_C.b{3};
W4C = net_C.LW{4,3};	b4C = net_C.b{4};

clear L1_a L1_st L1c uc x1c L2c

for (k = 1:validpts)

	L1c(:,k) = net_sim(xc(:,k), 	W1C,b1C,f1C, W2C,b2C,f2C, ...
					W3C,b3C,f3C, W4C,b4C,f4C);
	uc(:,k)  = opt_control(L1c(:,k));
	x1c(:,k) = state(xc(:,k), uc(:,k));
	L2c(:,k) = net_sim(x1c(:,k), 	W1C,b1C,f1C, W2C,b2C,f2C, ...
					W3C,b3C,f3C, W4C,b4C,f4C);
	L1_st(:,k) = costate(L2c(:,k), x1c(:,k));
	
	L1_a(:,k) = L1c(:,k);
	
end

% Error Calculation
% =================

err_C(m,1) = norm(L1_a - L1_st) / norm(L1_st);

disp('err_C =  '), disp(err_C);
disp('m =  '), disp(m);
disp('K =  '), disp(K);
