% Actual Training
% ===============

clear; clc; more off;

disp('Actual Training Starts');

load T_sim_pre;	% Loading the results from pre_training

consts;

Xb_dn = [0; 0; 0];
Xb_up = Xb_up0;

fac = 1.1;

counter = 0;

K = 1; 
while ( K > 0 ) 

	% Generation of Validation Data Points
	% ====================================

	if (Xb_up > Xb_up_f)
		
		counter = counter + 1;
		
		if (counter == 1)
			
			Xb_dn = Xb_dn_f;
			Xb_up = Xb_up_f;
 		else
		
			disp('Process Successfuly Completed.');
			break;
		end 
	end
	
	clear xc
	for (k = 1:validpts)
		
		if (k < validpts*1/4)
		
			xc(:,k)  = [Random(Xb_dn(1), Xb_up(1));
                           Random(Xb_dn(2), Xb_up(2));
                           Random(Xb_dn(3), Xb_up(3))];
	
		elseif (k > validpts*1/4) && (k < validpts*1/2)
	
			xc(:,k)  = [Random(-Xb_up(1), -Xb_dn(1));
                          Random(-Xb_up(2), -Xb_dn(2));
                          Random(-Xb_up(3), -Xb_dn(3))];
	
		elseif (k > validpts*0.9)
		
			xc(:,k)  = [Random(-Xb_up0(1), Xb_up0(1));
                          Random(-Xb_up0(2), Xb_up0(2));
                          Random(-Xb_up0(3), Xb_up0(3))];
	
		else
			xc(:,k)  = [Random(-Xb_up(1), Xb_up(1));
                        Random(-Xb_up(2), Xb_up(2));
                        Random(-Xb_up(3), Xb_up(3))];
		end

    end
	
	clear err_C
	
	m = 1; 
	while(m > 0)
	
          	if (ismultiple(m,5))
	
			clear xc
			for (k = 1:validpts)

				xc(:,k)  = [Random(Xb_dn(1), Xb_up(1));
                            Random(Xb_dn(2), Xb_up(2));
                            Random(Xb_dn(3), Xb_up(3))];
			end
          	end
          		
		disp('Starting the Critic Training');
		train_C;
		
		disp('Checking for Convergence');
		check_C;

	
		if ( all(err_C(m,:) < ERR_C) )
        		disp('Error criterion met. Training is Stopped');
        		break;	% Breaks Action Training! 
           	else
        		disp('Error criterion was not met. Training Continues');
	   	end
   		
   	   if (m == 1)
            net_C0 = net_C;
            err_C0 = err_C;
   	   end
   	   
   	   if (m >= 2)
   	   
   	   	if ( any(err_C(m,:) > err_C0) )
    	   		
    	   	Lrate_C = Lrate_C/2;
   	   		net_C = net_C0;
  	   	
   	   	else
   	   		Lrate_C = Lrate_C0;
   	   		net_C0 = net_C;
   	   		err_C0 = err_C;
   	   	end
   	   end
   	   
   	   m = m + 1;
   	end
   
	NET_C = net_C;
	
	if (Xb_up > Xb_up_f/2)
		
		fac = 1.05;
	end

	Xb_dn = Xb_up;
	Xb_up = fac * Xb_up;
   
   save T_sim_inf net_C
   K = K + 1;
   
end
