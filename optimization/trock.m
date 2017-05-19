
% Complete the state-space system matrices for estimation
[ M , N, As, Bs, Cs, Ds ] = mat_est;

M_c = M;

N_c = [ N(:,5) N(:,6) ];

Q_c =[ N(:,2) N(:,4)];

sys = ss(As,Bs,Cs,Ds);

Ts = 0.1;

sysd = c2d(sys, Ts,'Tustin');

% State-Space matrices for control in continous
% Ac = As;
% 
% Bc = [ Bs(5) Bs(6) ];
% 
% Ec =  [ Bs(2) Bs(4)];
% 
% Cc = [ Cs(2); Cs(4) ];
% 
% Dc = [ Ds(2,5) Ds(2,6); Ds(4,5) Ds(4,6) ];

% State-Space matrices for control in discrete
Ad = sysd.A;

Bd = [ sysd.B(5) sysd.B(6) ];

Ed = [ sysd.B(2) sysd.B(4)] ;
 
Cd = [ sysd.C(2); sysd.C(4) ];

Dd = [ sysd.D(2,5) sysd.D(2,6); sysd.D(4,5) sysd.D(4,6) ];

Kd = [ sysd.D(2,2) sysd.D(2,4); sysd.D(4,2) sysd.D(4,4) ];

E_new = Ed*pinv(Kd);     

WTconstant = (pi * (0.32)^2)/(1000*9.8);

%S =  - (1/WTconstant) * pinv(H_0) * H_1 * B_1';

save('sysd.mat','Ad','Bd','E_new','Cd','Dd','Ts')