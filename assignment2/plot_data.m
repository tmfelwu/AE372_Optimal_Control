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