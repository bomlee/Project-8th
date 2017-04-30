function [ a, B, C, D ] = Initialization( par, Ts )
%INITIALIZATION Summary of this function goes here
%   Detailed explanation goes here
matrices;
valve_param;
pipe_param;


[ lambdaD, lambdaC ] = Pipes_Tr( par );
[ gammaD, gammaC] = Tower_Tr( par );
[ mu_S_D, mu_S_C ] = Valves_States_Tr( par );
[ mu_I_D, mu_I_C ] = Valves_Inputs_Tr( par );
[ C1, C2 ] = Output( lambdaC, mu_I_C, mu_S_C, B_1);
[ alpha_S ] = Pumps( B_1 );
WTconstant = (pipe.e25.area)/(1000*9.8);

A = B_1 * (lambdaD + mu_S_D + gammaD) * B_1';

B1 = B_1 * mu_I_D *B_1' + alpha_S;

B2 = B_0;

H = - (1/WTconstant) * pinv(H_0) * H_1 * B_1';

B = - H * (A\B1);

a = - H * (A\B2);

C = C1 * ( -A\B2 );

D = ( C2 - C1 * ( A \ B1 ) );



end
% 
% pipe.lambda(1) pipe.lambda(2) pipe.lambda(3) pipe.lambda(4) pipe.lambda(5)... 
%     pipe.lambda(6) pipe.lambda(7) pipe.lambda(8) pipe.lambda(10) pipe.lambda(13)...
%     pipe.lambda(14) pipe.lambda(16) pipe.lambda(19) pipe.lambda(20) pipe.lambda(21)...
%     valve.muI(15) valve.muI(17) valve.muI(22) valve.muI(23)...
%     valve.muS(15) valve.muS(17) valve.muS(22) valve.muS(23)
