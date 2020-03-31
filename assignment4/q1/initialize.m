% Initialization
% ==============

disp('Initialization Starts')

X_range(:,1) = 1.2*Xb_dn_f; 
X_range(:,2) = 1.2*Xb_up_f;
% net_C = newff(X_range, [Cszinp,Cszh1,Cszout], {f1C,f2C,f4C});
net_C = newff(X_range, [Cszinp,Cszh1,Cszh2,Cszout], {f1C,f2C,f3C,f4C});
net_C.trainParam.epochs = 25;

disp('Initialization Ends')

