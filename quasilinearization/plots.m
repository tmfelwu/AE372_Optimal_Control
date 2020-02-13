plot(time, -state_history(:,2,100),'r','DisplayName','Quasilinearization')
hold on
plot(gradtime, u, 'b--o','DisplayName','GradientDescent','MarkerIndices',1:5:100)
xlabel('Time')
ylabel('Optimal Control(u)')
title('Time vs Optimal Control')
legend

%%
plot(time, state_history(:,1,100),'DisplayName','State Trajectory')
xlabel('Time')
ylabel('State')
%%
plot(time,state_history(:,2,100))
xlabel('Time')
ylabel('Costate')