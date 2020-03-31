function [time, y] = rk4(t0,tf,step,y0,func)
    time = [t0:step:tf]';
    [~,n] = size(y0);
    y = zeros(length(time),n);
    y(1,:) = y0;
    h = diff(time);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    for i=2:length(time)
        s = h(i-1);
%         k1 = feval(func,time(i-1), y(i-1,:));
%         k2 = feval(func,time(i-1) + s * 0.5, y(i-1,:) + 0.5*s*k1');
%         k3 = feval(func,time(i-1) + s * 0.5, y(i-1,:) + 0.5*s*k2');
%         k4 = feval(func,time(i-1) + s , y(i-1,:) + s*k3');
        k1 = func(time(i-1), y(i-1,:));
        k2 = func(time(i-1) + s * 0.5, y(i-1,:) + 0.5*s*k1');
        k3 = func(time(i-1) + s * 0.5, y(i-1,:) + 0.5*s*k2');
        k4 = func(time(i-1) + s , y(i-1,:) + s*k3');
        y(i,:) = y(i-1,:) + (s/6) * (k1 + 2*k2 + 2*k3 + k4 )';  
    end
end
