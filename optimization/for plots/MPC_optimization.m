%%
%Solve a quadratic programming problem

%Variabels that we need to sort out.
% delta_p_0 d_hp U_bar_hp q_bar_p_hp

% Variabels that we use in the Matrix_op.m file
% Lambda_A Lambda_B Lambda_C Gamma Psi Phi Theta Omega Pi
 
Matrix_op;trock3;%Load system matrices
load('Disturbance_Plot.mat');
t_1 = 0:3600:3600*(length(Data_OD)-1);
t_h_old = 0;


delta_p_0 = 0.005;      %small-signal initial WT pressure measurement

d_hp = 1*ones(48,1);      % Small signal deviation of the Valves OD
U_bar_hp = 0.2*ones(48,1);      % Input pressure to ring pumps operating point
q_bar_p_hp = 0.45*ones(48,1);    % Flow operating point of the ring pumps

%%%%%%%%%%%%%%%%%% General QP %%%%%%%%%%%%%%%%%%
% 0.5*x'R*x+f'*x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Constraint %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Output constraint
y_low =  0.08*ones(48,1);         % Full-signal upper and lower bounds 
y_high = 0.18*ones(48,1);           

% Pressure operating point of the PMA end-users
y_bar = [0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;
        0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;
        0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;
        0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991 ;0.1562; 0.0991];    

y1 = y_low - y_bar - Theta*Phi*delta_p_0-(Theta*Psi+Pi)*d_hp;
y2 = y_high - y_bar - Theta*Phi*delta_p_0-(Theta*Psi+Pi)*d_hp;
L_y = Theta*Gamma+Omega;

% State constraint
x_low = 0.055*ones(24,1);
x_high = 0.16*ones(24,1);
x_bar = 0.127*ones(24,1);

delta_p_wt_1 = x_low -x_bar - Phi*delta_p_0 - Psi*d_hp;
delta_p_wt_2 = x_high -x_bar - Phi*delta_p_0 - Psi*d_hp;
%delta_p_wt_2(1,1) = 0.014;
% input constraint 
u_low = -0.15;
u_high = 0.75;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Setting up the QP %%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = 2*(Lambda_A + Lambda_C*Gamma); 
R1=(R+R')/2;
R2=(R-R')/2;
f = ((U_bar_hp'*(Lambda_A+Lambda_C*Gamma)+d_hp'*(Lambda_B+Lambda_C*Psi)'+delta_p_0*(Lambda_C*Phi)'+q_bar_p_hp'));

%CONSTRAINTS FOR Y AND X
% A = [-L_y; L_y; -Gamma; Gamma];
%  b = [y1; y2; delta_p_wt_1; delta_p_wt_2];

%CONSTRAINTS only FOR Y
% A = [-L_y; L_y];
% b = [y1; y2];

%CONSTRAINTS only FOR X
A = [-Gamma;Gamma];
b = [delta_p_wt_1; delta_p_wt_2];

lb = u_low*ones(48,1);
ub = u_high*ones(48,1);

%trust-region-reflective
%  options = optimoptions('fmincon','Algorithm','interior-point','Display','iter-detailed');
% [u_hp,fval,exitflag,output,lambda] = quadprog(R1,f,[A],[b],[],[],[],[],[],options);
opts = optimoptions('quadprog',...
    'Algorithm','interior-point-convex','Display','iter');
[u_hp,fval,exitflag,output] = quadprog(R,f,[],[],[],[],[lb],[ub],[],opts)

%fval,lambda
% u_hp,exitflag,output

%fmincon(@(x)(0.5*(x')*R*x + f*x),zeros(size(ub)),[],[],[],[],lb,ub,[],options)
%quadprog(R,f,[],[],[],[],lb,ub,[],options)

%FOR TESTING:
controlsignal = u_hp;

% z = -f'\R;
% 
% u_hp1 = z(1:2:length(z))
% u_hp2 = z(2:2:length(z))

u_hp1 = u_hp(1:2:length(u_hp));
u_hp2 = u_hp(2:2:length(u_hp));


figure
subplot(3,1,1)       % add first plot in 2 x 1 grid
stairs([0:23], u_hp1)
title('u_{hp1}')
subplot(3,1,2)       % add second plot in 2 x 1 grid
stairs([0:23], u_hp2)       % plot using + markers
title('u_{hp2}')
subplot(3,1,3)       % add second plot in 2 x 1 grid
stairs([0:23], data(1:24))       % plot using + markers
title('Energy price')
% hold on 
% plot(1000*(-f'\R))

