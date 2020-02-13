%% Extract Relevant Data
time = x(:,2);
mach = x(:,1);
height = x(:,3);
distance = x(:,4);
gamma = 0:-stepsize:-180;

%% Plot of Mach Number vs Time
plot(time, mach)
xlabel('Time')
ylabel('Mach')
figure
plot(distance, height)
xlabel('Distance')
ylabel('Height')

%% Plot for AOA
for qit = 1:3
    plot(t_history(qit,:), alpha_history(qit,:)*180 /pi, 'DisplayName', sprintf("q = %d",q(qit)) );
    hold on
end
legend
xlabel('Time')
ylabel('Angle of attack')
hold off

%% Plot for Mach Numer vs time
hold off
for qit = 1:3
    plot(t_history(qit,:), M_history(qit,:), 'DisplayName', sprintf("q = %d",q(qit)) );
    hold on
end
legend
xlabel('Time')
ylabel('Mach Number')
hold off

%% Plot Gamma with Time
% for qit = 1:3
%     plot(t_history(qit,:), gamma(qit,:), 'DisplayName', sprintf("q = %d",q(qit)) );
%     hold on
% end
% legend
% hold off