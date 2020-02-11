function [time, y] = rk4(t0,tf,step,y0,func)
    time = [t0:step:tf]';
    [~,n] = size(y0);
    y = zeros(length(time),n);
    y(1,:) = y0;
    
    for i=2:length(time)
        k1 = step * func(time(i-1), y(i-1,:));
        k2 = step * func(time(i-1) + step/2 , y(i-1,:) + k1/2);
        k3 = step * func(time(i-1) + step/2 , y(i-1,:) + k2/2);
        k4 = step * func(time(i-1) + step , y(i-1,:) + k2);
        
        y(i,:) = y(i-1,:) + (1/6) * (k1 + 2*k2 + 2*k3 + k4 )';
    end
end