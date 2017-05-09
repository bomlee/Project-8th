clear all
clc
%% Initializing
valve_param;
pipe_param;
matrices;


zo = [1 2 1 2 3 2 1 2]';

[ lambdaD, lambdaC, pipe ] = Pipes( pipe, B_1, zo );
[ mu_S_D, mu_S_C, valve ] = Valves_States( valve, B_1, zo );
[ mu_I_D, mu_I_C, valve ] = Valves_Inputs( valve, B_1, zo);
[ gammaD, gammaC, pipe ] = Tower( pipe, B_1, zo );


%% Load data from the lab
% load('parest_WT_cont_4inone.mat')
load('0905_1340_short_wpumpandvalve.mat') % fits really great
Ts = 0.05;
u = u_sm;
y = y_sm;
s = s_sm;
u(:,1:4) = 90 * u(:,1:4);
y = [y(:, 5:end) s ];
z = iddata(y,u,Ts,'Name', 'Data from Lab');
z.InputName = {'e13Cv', 'e15Cv', 'e20Cv', 'e22Cv','e01dp', 'e08dp', 'e09dp','e12dp'};
z.InputUnit =  {'-','-','-','-','bar', 'bar', 'bar','bar'};
z.OutputName = {'Node11','Node10','Node16','Node 15','WT'};
z.OutputUnit = { 'bar','bar','bar','bar','bar'};

%% Set up the ident model
% load('prediction.mat')
 Parameters =   {[pipe.lambda(1); pipe.lambda(2); pipe.lambda(3); pipe.lambda(4); pipe.lambda(5); ...
    pipe.lambda(6); pipe.lambda(7); pipe.lambda(8); pipe.lambda(10); pipe.lambda(13);...
    pipe.lambda(14); pipe.lambda(16); pipe.lambda(19); pipe.lambda(20); pipe.lambda(21); pipe.gamma(24);...
    valve.muI(15,1); valve.muI(17,2); valve.muI(22,3); valve.muI(23,4);...
    valve.muS(15); valve.muS(17); valve.muS(22); valve.muS(23)]};

linear_model = idgrey('Initialization', Parameters, 'c');

opt = greyestOptions('InitialState','zero','Display','on','SearchMethod', 'gn');
opt.SearchOption.MaxIter = 150;

datestr(now)
linear_estimation = greyest(z, linear_model, opt);
[linear_b_est,dlinear_b_est] = getpvec(linear_estimation,'free');
datestr(now)
figure
compare(z, linear_model, linear_estimation);
