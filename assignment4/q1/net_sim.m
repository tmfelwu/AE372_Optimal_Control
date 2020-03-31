function y = net_sim(x, W1,b1,f1,W2,b2,f2,W3,b3,f3,W4,b4,f4)
%
% This Simulates a One/Two/Three/Four-Layer Neural Network
%
% Usage: 
%		y = net_sim(x, W1,b1,f1)
%		y = net_sim(x, W1,b1,f1,W2,b2,f2)
%		y = net_sim(x, W1,b1,f1,W2,b2,f2,W3,b3,f3)
%		y = net_sim(x, W1,b1,f1,W2,b2,f2,W3,b3,f3,W4,b4,f4)
% 
% where,	
%		x = Input to the Network
%		y = Output from the Network
%		
%		W1 = Weight Matrix for the First Layer
%		b1 = Bias Vector for the First Layer
%		f1 = Function for the First Layer
%		W2 = Weight Matrix for the Second Layer
%		b2 = Bias Vector for the Second Layer
%		f2 = Function for the Second Layer
%		W3 = Weight Matrix for the Third Layer
%		b3 = Bias Vector for the Third Layer
%		f3 = Function for the Third Layer
%		W4 = Weight Matrix for the Third Layer
%		b4 = Bias Vector for the Fourth Layer
%		f4 = Function for the Fourth Layer
%`
%	Note: 	f1, f2 etc. must be strings


if (nargin == 4)

	n1 = W1*x + b1;
	y  = feval(f1, n1);

elseif (nargin == 7)
	
	n1 = W1*x + b1;
	a1 = feval(f1, n1);
	
	n2 = W2*a1 + b2;
	y  = feval(f2, n2);
	
elseif (nargin == 10)

	n1 = W1*x + b1;
	a1 = feval(f1, n1);
	
	n2 = W2*a1 + b2;
	a2 = feval(f2, n2);

	n3 = W3*a2 + b3;
	y = feval(f3, n3);

elseif (nargin == 13)
	
	n1 = W1*x + b1;
	a1 = feval(f1, n1);
	
	n2 = W2*a1 + b2;
	a2 = feval(f2, n2);

	n3 = W3*a2 + b3;
	a3 = feval(f3, n3);
	
	n4 = W4*a3 + b4;
	y = feval(f4, n4);
	
else
	error('Error in using net_sim function')
end
