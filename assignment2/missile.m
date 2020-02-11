%Missile Guidance
clc
clear
a = 343    ; % Speed of sound m/s
rho = 1.22 ; % TODO : Need to update for 5kms
mass = 240 ; % kg
g = -9.8;
S = 0.0707 ; 
T = 24000  ; % Newton
Tw = T / ( mass * g);
Cd = 0.5   ;
Cl = 3.12  ;
Sw = rho* a^2 * S / ( 2 * mass* g);
stepsize = 0.5;
gamma = 0:-stepsize:-180;
rgamma = -180:stepsize:0;
alphat = gamma;
q = 10;
% Step  1 Assume the control history
alpha = alphat * 0 + 1;

for j=1:20
% Step 2 Integrate the state equation forward
[xt, x] = rk4( 0, -180, -stepsize, [0.5 0], @(t,x) forward(t,x,alphat, alpha, Sw, Cl, Tw, Cd, a, g) );

% Step 3 Find final conditions and backward integrate the costate equation
M = x(:,1);
l1 = [q*(M(end)-0.8), 0];
[lt,l] = rk4( -180,0 , stepsize, l1 ,@(t,l) backward(t,l, a,g,Cl, Sw, Tw, Cd, alphat, alpha, xt, x ));

% Step 4 Verify if the control equation is satisfied
lambda1 = flip(l(:,1));
lambda2 = flip(l(:,2));
dHdAlpha = (M*Tw.*lambda1.*cos(alpha').*(Cd*Sw*M.^2 + sin(gamma') - Tw*cos(alpha')))./...
    (Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')).^2 - ...
    (M*Tw*a.*cos(alpha'))./(g*(Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')).^2) - ...
    (M*Tw.*lambda1.*sin(alpha'))./(Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')) - ...
    (M*Tw*a.*lambda2.*cos(alpha'))./(g*(Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')).^2);
tau = 0.1;
plot(gamma, alpha);
hold on
alpha = alpha - tau * dHdAlpha';
end

% Plotting the optimal control
% plot(time, -0.5806 * exp(time), 'r--')

function dx = forward(gamma,x, alphat, alpha, Sw , Cl, Tw, Cd, a,g)
alpha = interp1(alphat,alpha,gamma);
M = x(1);
denom = (Sw * M^2 * Cl - cos(gamma) + Tw * sin(alpha) );
dx(1) = ( - Sw * M^2 * Cd - sin(gamma) + Tw * cos(gamma)) * M / denom;
dx(2) = (M*a)/(g*(Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha)));
dx = dx';
end

function dl = backward(gamma,l,a,g,Cl, Sw, Tw, Cd, alphat, alpha, xt, x)
alpha = interp1(alphat, alpha, gamma);
M = interp1(xt,x(:,1),gamma);
lambda1 = l(1);
lambda2 = l(2);
dl(1) = a/(g*(Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha))) - (lambda1*(Cd*Sw*M^2 + sin(gamma) - Tw*cos(alpha)))/...
    (Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha)) + (a*lambda2)/(g*(Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha))) - ...
    (2*Cd*M^2*Sw*lambda1)/(Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha)) +...
    (2*Cl*M^2*Sw*lambda1*(Cd*Sw*M^2 + sin(gamma) - Tw*cos(alpha)))/...
    (Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha))^2 - (2*Cl*M^2*Sw*a)/(g*(Cl*Sw*M^2 - cos(gamma) +...
    Tw*sin(alpha))^2) - (2*Cl*M^2*Sw*a*lambda2)/(g*(Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha))^2);
dl(2) = 0;
dl = dl';
end