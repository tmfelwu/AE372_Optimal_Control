% Pre-training
% ============

Xb_dn = Xb_dn0;
Xb_up = Xb_up0;

% Generation of Validation Data
% =============================

for (k = 1:validpts)

	xc(:,k)  = [Random(Xb_dn(1), Xb_up(1));
                  Random(Xb_dn(2), Xb_up(2));
                  Random(Xb_dn(3), Xb_up(3))]; 

	uc(:,k)  = -Kd*xc(:,k);
	x1c(:,k) =  Ad*xc(:,k) + Bd*uc(:,k);
	L1c_st(:,k)= Sd*x1c(:,k);	% Target Critic	
		
	u1c(:,k)  = -Kd*x1c(:,k);
	x2c(:,k) =  Ad*x1c(:,k) + Bd*u1c(:,k);
	L2c_st(:,k)= Sd*x2c(:,k);	% Target Critic	

end

m = 1; 
while ( m > 0 ) 
	
	pretrain;
	check_pre;
	
	if (all(err_C(m,:) < ERR_C))
        	disp('Error criterion met for Pre_training. Training is Stopped');
            break;	% Breaks Action Training! 
    else
            disp('Error criterion was not met for Pre_training. Training Continues');
	end
   
    m = m + 1;
end

NET_C = net_C;	% Saving the converged Network
