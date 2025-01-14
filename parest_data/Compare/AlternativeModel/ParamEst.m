%% Initial Values
clear all
clc
pipe_param;

%  pipe.e02.q0 = 0.5;
%  pipe.e04.q0 = 0.5;
%  pipe.e05.q0 = 0.5;
%  pipe.e06.q0 = 0.5;
%  pipe.e11.q0 = 0.5;
%  pipe.e21.q0 = 0.5;
%  pipe.e23.q0 = 0.5;

% x0 = [0.000000000113370
%    0.273490771269440
%    0.000000000000028
%    0.288559410641489
%    0.000266688545476
%    1.837629665797334
%    1.832488026457060];


% x0 = [0.146279274973641
%    0.075995847153939
%    0.000249323037675
%    0.000000017871043
%    0.033330560073188
%    0.034815231488127
%    0.000275506277596];

x0 = [0.8519
    0.6036
    0.0000
    0.0000
    0.0000
    0.3085
    0.0000];

Ts = 0.05;
%% load data from the lab
load('data');
% u(5:end) = 10^5*u(5:end);
% y = 10^5 * y;

z = iddata(y,u,Ts,'Name', 'Data from Lab');
z.InputName = {'e13Cv', 'e15Cv', 'e20Cv', 'e22Cv','e01dp', 'e08dp', 'e09dp','e12dp'};
z.InputUnit =  {'-','-','-','-','bar', 'bar', 'bar','bar'};
z.OutputName = {'Node 2','Node 7','Node 4','Node 5' ...
          'Node 11', 'Node10', 'Node 16','Node 15'};
z.OutputUnit = { 'bar','bar','bar','bar', 'bar', 'bar','bar','bar'};
% z.Tstart = 0;

% load('Closing_valve.mat')
% T = Outputs.time;
% 
% u = zeros(length(T),8);
% % Valves inputs
% u(:,1) = Outputs3.signals.values(:,1);
% u(:,2) = Outputs3.signals.values(:,2);
% u(:,3) = Outputs3.signals.values(:,3);
% u(:,4) = Outputs3.signals.values(:,4);
% % PMA inputs
% u(:,5) = Outputs1.signals.values(:,1);
% u(:,6) = Outputs1.signals.values(:,2);
% u(:,7) = Outputs1.signals.values(:,3);
% u(:,8) = Outputs1.signals.values(:,4);
% 
% y = zeros(length(T),8);
% % Ring pressures
% y(:,1) = Outputs2.signals.values(:,1);
% y(:,2) = Outputs2.signals.values(:,2);
% y(:,3) = Outputs2.signals.values(:,3);
% y(:,4) = Outputs2.signals.values(:,4);
% %Pma pressures
% y(:,5) = Outputs.signals.values(:,1);
% y(:,6) = Outputs.signals.values(:,2);
% y(:,7) = Outputs.signals.values(:,3);
% y(:,8) = Outputs.signals.values(:,4);
% 
% Data1 = 436;
% Data2 = 1560;
% Data3 = 2700;
% Data4 = 3960;
% Offshet = 40;
% 
% u1 = [ u(Data1:Data1+Offshet,1)' u(Data2:Data2+Offshet,1)' u(Data3:Data3+Offshet,1)' u(Data4:Data4+Offshet,1)';...
% u(Data1:Data1+Offshet,2)' u(Data2:Data2+Offshet,2)' u(Data3:Data3+Offshet,2)' u(Data4:Data4+Offshet,2)';...
% u(Data1:Data1+Offshet,3)' u(Data2:Data2+Offshet,3)' u(Data3:Data3+Offshet,3)' u(Data4:Data4+Offshet,3)';...
% u(Data1:Data1+Offshet,4)' u(Data2:Data2+Offshet,4)' u(Data3:Data3+Offshet,4)' u(Data4:Data4+Offshet,4)';...
% u(Data1:Data1+Offshet,5)' u(Data2:Data2+Offshet,5)' u(Data3:Data3+Offshet,5)' u(Data4:Data4+Offshet,5)';...
% u(Data1:Data1+Offshet,6)' u(Data2:Data2+Offshet,6)' u(Data3:Data3+Offshet,6)' u(Data4:Data4+Offshet,6)';...
% u(Data1:Data1+Offshet,7)' u(Data2:Data2+Offshet,7)' u(Data3:Data3+Offshet,7)' u(Data4:Data4+Offshet,7)';...
% u(Data1:Data1+Offshet,8)' u(Data2:Data2+Offshet,8)' u(Data3:Data3+Offshet,8)' u(Data4:Data4+Offshet,8)']';
% 
% y1 = [ y(Data1:Data1+Offshet,1)' y(Data2:Data2+Offshet,1)' y(Data3:Data3+Offshet,1)' y(Data4:Data4+Offshet,1)';...
% y(Data1:Data1+Offshet,2)' y(Data2:Data2+Offshet,2)' y(Data3:Data3+Offshet,2)' y(Data4:Data4+Offshet,2)';...
% y(Data1:Data1+Offshet,3)' y(Data2:Data2+Offshet,3)' y(Data3:Data3+Offshet,3)' y(Data4:Data4+Offshet,3)';...
% y(Data1:Data1+Offshet,4)' y(Data2:Data2+Offshet,4)' y(Data3:Data3+Offshet,4)' y(Data4:Data4+Offshet,4)';...
% y(Data1:Data1+Offshet,5)' y(Data2:Data2+Offshet,5)' y(Data3:Data3+Offshet,5)' y(Data4:Data4+Offshet,5)';...
% y(Data1:Data1+Offshet,6)' y(Data2:Data2+Offshet,6)' y(Data3:Data3+Offshet,6)' y(Data4:Data4+Offshet,6)';...
% y(Data1:Data1+Offshet,7)' y(Data2:Data2+Offshet,7)' y(Data3:Data3+Offshet,7)' y(Data4:Data4+Offshet,7)';...
% y(Data1:Data1+Offshet,8)' y(Data2:Data2+Offshet,8)' y(Data3:Data3+Offshet,8)' y(Data4:Data4+Offshet,8)']';
% % 
% z = iddata(y1,u1,Ts,'Name', 'Data from Lab');
% z.InputName = {'e13Cv', 'e15Cv', 'e20Cv', 'e22Cv','e01dp', 'e08dp', 'e09dp','e12dp'};
% z.InputUnit =  {'-','-','-','-','bar', 'bar', 'bar','bar'};
% z.OutputName = { 'Node 2','Node 7','Node 4','Node 5' ...
%           'Node 11', 'Node10', 'Node 16','Node 15'};
% z.OutputUnit = { 'bar','bar','bar','bar', 'bar', 'bar','bar','bar'};
% z.Tstart = 0;
% 

%% setup of the ident model
FileName      = 'zdot';       % File describing the model structure.
Order         = [8 8 7];           % Model orders [ny nu nx].

Parameters    = {[ pipe.e02.Cp;  pipe.e04.Cp;  pipe.e05.Cp; ...
     pipe.e06.Cp;  pipe.e11.Cp;  pipe.e21.Cp;  pipe.e23.Cp;  pipe.e03.Cp;  pipe.e07.Cp;...
     pipe.e10.Cp;  pipe.e12.Cp;  pipe.e14.Cp;  pipe.e17.Cp;  pipe.e18.Cp;  pipe.e19.Cp]}; % Initial parameters. Np = 15.

InitialStates = x0;            % Initial initial states.
nlgr = idnlgrey(FileName, Order, Parameters, InitialStates, 0, ...
                'Name', 'First Simulation');
    

nlgr.Parameters.Minimum(1:15) = 0;  % nlgr.Parameters.Maximum(1:15) = 10;

nlgr.InitialStates(1).Minimum = 0;
nlgr.InitialStates(2).Minimum = 0;
nlgr.InitialStates(3).Minimum = 0;
nlgr.InitialStates(4).Minimum = 0;
nlgr.InitialStates(5).Minimum = 0;
nlgr.InitialStates(6).Minimum = 0;
nlgr.InitialStates(7).Minimum = 0;

nlgr.InitialStates(1).Fixed = false;
nlgr.InitialStates(2).Fixed = false;
nlgr.InitialStates(3).Fixed = false;
nlgr.InitialStates(4).Fixed = false;
nlgr.InitialStates(5).Fixed = false;
nlgr.InitialStates(6).Fixed = false;
nlgr.InitialStates(7).Fixed = false;

nlgr.Algorithm.MaxIter=5;
%%
%
% In practice, there are disturbances that affect the outputs. An
% |idnlgrey| model does not explicitly model the disturbances, but assumes
% that these are just added to the output(s). Thus, |idnlgrey| models are
% equivalent to Output-Error (OE) models. Without a noise model, past
% outputs do not influence prediction of future outputs, which means that
% predicted output for any prediction horizon k coincide with simulated
% outputs.
%%
%
% 3. Specify input and output names, and units.
set(nlgr, 'InputName', {'e13Cv', 'e15Cv', 'e20Cv', 'e22Cv','e01dp', 'e08dp', 'e09dp','e12dp'},...
          'InputUnit',{ '-','-','-','-','bar', 'bar', 'bar','bar'},...
          'OutputName', { 'Node 2','Node 7','Node 4','Node 5' ...
          'Node 11', 'Node10', 'Node 16','Node 15'},...
          'OutputUnit', {'bar','bar','bar','bar', 'bar', 'bar','bar','bar'},...                        
          'TimeUnit', 's');
%%
% 
% Specify names and units of the initial states and parameters.
setinit(nlgr, 'Name', {'e02q' 'e04q' 'e05q' 'e06q' 'e11q' 'e21q' 'e23q'});
setinit(nlgr, 'Unit', {'m^3/h' 'm^3/h' 'm^3/h' 'm^3/h' 'm^3/h' 'm^3/h' 'm^3/h'});
setpar(nlgr, 'Name', {'Cp'});
setpar(nlgr, 'Unit', {'-'});
% nlgr.Parameters.Minimum(:) = zeros(15, 1) ;

% disp('The basic information about the model.')
% size(nlgr)
% present(nlgr)
%  opt = compareOptions;
%  opt.InitialCondition = x0;
 datestr(now)
%% Estimation
% opt = nlgreyestOptions('Display','on');
% opt.SearchOption.MaxIter = 18;

% % sys = nlgreyest(z, nlgr,opt);
% nlgrF = pem(z, nlgr,'Display', 'Full' , 'InitialState', x0 );
% nlgrF.Name = 'New Estimation';
% % nlgr.Report
% % fprintf('\n\nThe search termination condition:\n')
% % nlgr.Report.Termination
% compare(z, nlgr, nlgrF, 'init', 'm');
% datestr(now)
% p=nlgrF.Parameters.Value % save the new parameters
%% Compare and plot
figure
compare(z, nlgr, 'init', 'm')

q = compare(z, nlgr, 'init', 'm');
Tss = 0.05*[1:1:3200];
%%

figure
plot(Tss,z.y(:,1),Tss,q.y(:,1))
grid on 
title('Node 2')
ylabel('Amplitude [Bar]')
xlabel('Time [s]')
legend('Data from lab (Node 2)','First simulation: 67.45 %')

figure
plot(Tss,z.y(:,2),Tss,q.y(:,2))
grid on 
title('Node 7')
ylabel('Amplitude [Bar]')
xlabel('Time [s]')
legend('Data from lab (Node 7)','First simulation: 72.99 %')

figure
plot(Tss,z.y(:,3),Tss,q.y(:,3))
grid on 
title('Node 4')
ylabel('Amplitude [Bar]')
xlabel('Time [s]')
legend('Data from lab (Node 4)','First simulation: 11.15 %')

figure
plot(Tss,z.y(:,4),Tss,q.y(:,4))
grid on 
title('Node 5')
ylabel('Amplitude [Bar]')
xlabel('Time [s]')
legend('Data from lab (Node 5)','First simulation: -11.63 %')

figure
plot(Tss,z.y(:,5),Tss,q.y(:,5))
grid on 
title('Node 11')
ylabel('Amplitude [Bar]')
xlabel('Time [s]')
legend('Data from lab (Node 11)','First simulation: -185.2 %')

figure
plot(Tss,z.y(:,6),Tss,q.y(:,6))
grid on 
title('Node 10')
ylabel('Amplitude [Bar]')
xlabel('Time [s]')
legend('Data from lab (Node 10)','First simulation: -397.6 %')

figure
plot(Tss,z.y(:,7),Tss,q.y(:,7))
grid on 
title('Node 16')
ylabel('Amplitude [Bar]')
xlabel('Time [s]')
legend('Data from lab (Node 16)','First simulation: -323.5 %')

figure
plot(Tss,z.y(:,8),Tss,q.y(:,8))
grid on 
title('Node 15')
ylabel('Amplitude [Bar]')
xlabel('Time [s]')
legend('Data from lab (Node 15)','First simulation: -483.5 %')