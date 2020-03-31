

% Weights from the Networks
% =========================

W1C = net_C.IW{1,1};	b1C = net_C.b{1};
W2C = net_C.LW{2,1};	b2C = net_C.b{2};
W3C = net_C.LW{3,2};	b3C = net_C.b{3};
W4C = net_C.LW{4,3};	b4C = net_C.b{4};


for (k = 1:trainpts)

	if (k < trainpts*1/4)
		
		x(:,k)  = [Random(Xb_dn(1), Xb_up(1));
                     Random(Xb_dn(2), Xb_up(2));
                     Random(Xb_dn(3), Xb_up(3))];
	
	elseif (k > trainpts*1/4) && (k < trainpts*1/2)
	
		x(:,k)  = [Random(-Xb_up(1), -Xb_dn(1));
                    Random(-Xb_up(2), -Xb_dn(2));
                    Random(-Xb_up(3), -Xb_dn(3))];
	
	elseif (k > trainpts*0.9)
		
		x(:,k)  = [Random(-Xb_up0(1), Xb_up0(1));
                     Random(-Xb_up0(2), Xb_up0(2));
                     Random(-Xb_up0(3), Xb_up0(3))];

	else
		x(:,k)  = [Random(-Xb_up(1), Xb_up(1));
                    Random(-Xb_up(2), Xb_up(2));
                    Random(-Xb_up(3), Xb_up(3))];
	end
	
	
	L1(:,k) = net_sim(x(:,k), 	W1C,b1C,f1C, W2C,b2C,f2C, ...
                                W3C,b3C,f3C, W4C,b4C,f4C);

	u(:,k)  = opt_control(L1(:,k));
	x1(:,k) = state(x(:,k), u(:,k));
	
	L2(:,k) = net_sim(x1(:,k),	W1C,b1C,f1C, W2C,b2C,f2C, ... 
                                W3C,b3C,f3C, W4C,b4C,f4C);
  
	L1_st(:,k) = costate(L2(:,k), x1(:,k));
	
	L1_a(:,k) = L1(:,k);

end

% Training of the Network
% =======================

L1_T = Lrate_C*L1_st + (1-Lrate_C)*L1_a;    % Giving a convex combination 
                                            % as target helps in
                                            % convergence
net_C = train(net_C, x, L1_T);
