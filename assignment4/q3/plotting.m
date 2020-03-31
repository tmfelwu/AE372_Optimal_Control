%% Lets do some plotting

figure
plot(t,X_opt(1,:));
xlabel('time')
ylabel('State x0')

figure
plot(t,X_opt(2,:));
xlabel('time')
ylabel('State x1')

figure
plot(t,U_opt)
xlabel('time')
ylabel('control')