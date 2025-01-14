clear , clc, 
% Sample Time
Ts = 6.438500000000000;
Ts_h = 3600;

% Load end-users consumption
load('Disturbance_Plot.mat');
t_1 = 0:3600:3600*(length(Data_OD)-1);
t_h_old = 0;

input = [ones(2,1)];
constant_dist = [ones(2,1)];

% Load discrete state-space system matrix
matrices, trock;