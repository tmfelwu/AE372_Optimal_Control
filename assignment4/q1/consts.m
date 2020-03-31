% These are Constants Related to Neural Networks
% ==============================================

trainpts = 1000;	% No. of Training Points in the interval
validpts = 1000;    % No. of Test Points
train_times = 1;	% No. of times each network is trained for 
                    %   each random data set
                    
% Network Structure
% =================

Aszinp = 3;	Cszinp = 3;
Aszh1  = 6;	Cszh1  = 6;
Aszh2  = 6;	Cszh2  = 6;
Aszout = 3;	Cszout = 3;
		
f1A = 'tansig'; f2A = 'tansig'; f3A = 'tansig'; f4A = 'purelin';
f1C = 'tansig'; f2C = 'tansig'; f3C = 'tansig'; f4C = 'purelin';

% Termination Error (relative) Criteria
% =====================================

ERR_C = 0.05;	     % for Critic Networks
ERR_C_f = ERR_C;

% Learning Rates for Targets
% ==========================

Lrate_C0 = 0.4;
Lrate_C = Lrate_C0;

% Time Step
% =========

dt = 0.01;

% Linear Model & Weighting Factors
% ================================
A = [-5  -100  0;
        0      0    1;
     -0.1  -1  -0.5];
B = [1000;
       0;
       0];
Qw = eye(3);
Rw = 1;

Ad = eye(3) + dt*A;
Bd = dt*B;
Qd = dt*Qw;
Rd = dt*Rw;

% LQR Solution
% =============

[Kd, Sd, E] = dlqr(Ad,Bd,Qd,Rd);


% Boundary of x, for which the result is desired
% ==============================================

Xb_dn0 = [-0.05; -0.05; -0.05];
Xb_up0 =  [0.05; 0.05; 0.05];

Xb_dn_f = [-1;-1; -1];
Xb_up_f = [1; 1 ;1];
