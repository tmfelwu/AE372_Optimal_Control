%Missile Guidance
clc
clear
a = 320.5    ; % Speed of sound m/s
rho = .736 ; % TODO : Need to update for 5kms
mass = 240 ; % kg
g = 9.8    ;
S = 0.0707 ; 
T = 24000  ; % Newton
Tw = T / ( mass * g);
Cd = 0.5   ;
Cl = 3.12  ;
Sw = (rho* a^2 * S) / ( 2 * mass* g);
stepsize = (0.2* pi) / 180;
gamma = 0:-stepsize:-pi;
alphat = gamma;
% Step  1 Assume the control history
alpha = zeros(size(alphat)) - (80) * pi /180 ;
num_iterations = 5;
q = [1 10 100];
J = zeros(length(q),length(num_iterations));
alpha_history = zeros(length(q),length(gamma));
M_history = zeros(length(q),length(gamma));
t_history = zeros(length(q), length(gamma));
for qit=1:length(q)
    j = 1;
    while j <10
        % Step 2 Integrate the state equation forward
        % initial conditions are Mach number, time, x, height
        [xt, x] = rk4( 0, -pi, -stepsize, [0.5 0 5000 0], @(t,x) forward(t,x,alphat, alpha, Sw, Cl, Tw, Cd, a, g) );
        % x = ode4(@(t,x) forward(t,x,alphat, alpha, Sw, Cl, Tw, Cd, a, g), [0:-stepsize:-pi], [0.5 0 5000 0]);
        % xt = [0:-stepsize:-pi];
        % Step 3 Find final conditions and backward integrate the costate equation
        M = x(:,1);
        time = x(:,2);
        l1 = [q(qit)*(M(end)-0.8), 0, 0, 0];
        [lt,l] = rk4( -pi,0 , stepsize, l1 ,@(t,l) backward(t,l, a,g,Cl, Sw, Tw, Cd, alphat, alpha, xt, x ));
        %l = ode4(@(t,l) backward(t,l, a,g,Cl, Sw, Tw, Cd, alphat, alpha, xt, x ), [-pi:stepsize:0], l1);
        %lt = [-pi:stepsize:0]';

        % Step 4 Verify if the control equation is satisfied
        lambda1 = flip(l(:,1));
        lambda2 = flip(l(:,2));
        lambda3 = flip(l(:,3));
        lambda4 = flip(l(:,4));
        dHdAlpha = (M*Tw.*lambda1.*cos(alpha').*(Cd*Sw*M.^2 + sin(gamma') - Tw*cos(alpha')))./ ...
            (Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')).^2 - (M*Tw*a.*cos(alpha'))./ ...
            (g*(Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')).^2) - (M*Tw.*lambda1.*sin(alpha'))./ ...
            (Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')) - (M*Tw*a.*lambda2.*cos(alpha'))./ ...
            (g*(Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')).^2) - (M.^2*Tw*a^2.*lambda3.*cos(alpha').*sin(gamma'))./ ...
            (g*(Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')).^2) - (M.^2*Tw*a^2.*lambda4.*cos(alpha').*cos(gamma'))./ ...
            (g*(Cl*Sw*M.^2 - cos(gamma') + Tw*sin(alpha')).^2);
        percentage_reduction = 5;
        J(qit,j) = 0.5*q(qit)*(M(end)-0.8) + time(end);
        denominator = trapz(time,dHdAlpha.^2);
        tau = ((percentage_reduction/100)* J(qit,j))/(denominator);
        plot(x(:,4), x(:,3));
        hold on
        alpha = alpha - tau * dHdAlpha';
        j = j+1;
    end
    
    M_history(qit,:) = x(:,1)';
    alpha_history(qit,:) = alpha;
    t_history(qit,:) = x(:,2)';
    plot(x(:,4),x(:,3),'DisplayName',sprintf("q = %d", q(qit)));
    hold on
end
legend

% Plotting the optimal control
% plot(time, -0.5806 * exp(time), 'r--')

function dx = forward(gamma,x, alphat, alpha, Sw , Cl, Tw, Cd, a,g)
alpha = interp1(alphat,alpha,gamma);
M = x(1);
denom = (Sw * M^2 * Cl - cos(gamma) + Tw * sin(alpha) );
dx(1) = (( - Sw * M^2 * Cd - sin(gamma) + Tw * cos(alpha)) * M )/ denom;
dx(2) = (M*a)/(g*(Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha)));
dx(3) = (a^2 * M^2 * sin(gamma))/ (g*denom); 
dx(4) = (a^2 * M^2 * cos(gamma))/ (g*denom);
dx = dx';
end

function dl = backward(gamma,l,a,g,Cl, Sw, Tw, Cd, alphat, alpha, xt, x)
alpha = interp1(alphat, alpha, gamma);
M = interp1(xt,x(:,1),gamma);
lambda1 = l(1);
lambda2 = l(2);
lambda3 = l(3);
lambda4 = l(4);
dl(1) = - (-(a*cos(gamma) - (g*lambda1*sin(2*gamma))/2 - Tw*a*sin(alpha) + a*lambda2*cos(gamma) + 2*M*a^2*lambda4*cos(gamma)^2 + Cl*M^2*Sw*a + M*a^2*lambda3*sin(2*gamma) - (Tw^2*g*lambda1*sin(2*alpha))/2 - Tw*a*lambda2*sin(alpha) + Tw*g*lambda1*cos(alpha)*cos(gamma) + Tw*g*lambda1*sin(alpha)*sin(gamma) + Cl*M^2*Sw*a*lambda2 + Cd*Cl*M^4*Sw^2*g*lambda1 - 3*Cd*M^2*Sw*g*lambda1*cos(gamma) - Cl*M^2*Sw*g*lambda1*sin(gamma) - 2*M*Tw*a^2*lambda4*cos(gamma)*sin(alpha) - 2*M*Tw*a^2*lambda3*sin(alpha)*sin(gamma) + Cl*M^2*Sw*Tw*g*lambda1*cos(alpha) + 3*Cd*M^2*Sw*Tw*g*lambda1*sin(alpha))/(g*(Cl*Sw*M^2 - cos(gamma) + Tw*sin(alpha))^2));
dl(2) = - 0;
dl(3) = - 0;
dl(4) = - 0;
dl = dl';
end