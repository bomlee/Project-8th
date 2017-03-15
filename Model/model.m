clear all; 
clc;
%Model 

%Including parameters
inertia_parameters
HandBmatrix
elevation_parameters
f_matrix

%%The inertia function can be used to get inertia matrices 

J = inertiaFunc(L,D);

si = ElevationFunc(delta_z);

%Setting up state-space model

%Z = B_1 * J * B_1' * B_1 * F 