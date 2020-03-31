


% Generation of Training Data
% ===========================

for (k = 1:trainpts)

	x(:,k) = [Random(Xb_dn(1), Xb_up(1));
                Random(Xb_dn(2), Xb_up(2));
                Random(Xb_dn(3), Xb_up(3))];
    
	u(:,k)  = -Kd*x(:,k);
	x1(:,k) =  Ad*x(:,k) + Bd*u(:,k);
	L1(:,k) =  Sd*x1(:,k);
	
end

% Training
% ========

net_C = train(net_C, x , L1);

