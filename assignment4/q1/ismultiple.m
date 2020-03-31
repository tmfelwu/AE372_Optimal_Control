function z = ismultiple(n,m);
%
% This function checks whether n is a multiple of m
%
%	Usage : y = ismultiple(n,m)

  	
y = n / m;

y1 = round(y); 


if ( abs((y-y1) / y) < 1e-6 )

	z = 1;
else

	z = 0;
end

