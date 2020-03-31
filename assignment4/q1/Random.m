function y = Random(a,b)
%
% This generates uniform integer random numbers in the interval [a,b]
%
% 	Usage : y = Random(a,b)

[m1,n1] = size(a);
[m2,n2] = size(b);

if ( (m1 ~= 1) | (n1 ~= 1) | (m2 ~= 1) |(n2 ~= 1) )
   error( ' a and b must be scalars');
end

x = rand;
diff = abs(b-a);
y = x*diff + min(a,b);
% y = 0.5;

