clear all;
close all;
clc;
%% Preparing data for Feedback coeficients - LN stochastic p. 28
% 
data = load('data_v2.csv'); % Data
data_mean = data(:,3) - mean(data(:,3)); % Mean substracted from data 
% 
% atc = autocorr(data_mean); % Autocorrelation of data
%  
% y_gamma = atc(2:length(atc)); % Used in Yule walker 
% Gamma = toeplitz(atc(1:length(atc)-1)); % Used in Yule walker
% 
% sigma = inv(Gamma)*y_gamma; % Feedback coeificients for AR(20)


%%

% f = linspace(0,1,length(data(:,3)));

x = data_mean;
x_f = fft(x);

% By visual inspection. x = 15, 155 is peak of fft 

theta = [angle(x_f(2)) angle(x_f(15)) angle(x_f(29)) angle(x_f(6)) angle(x_f(8)) angle(x_f(10))];
%angle(x_f(155));
%fz = 


x_f(2) = 0;
x_f(168) = 0;

x_f(15) = 0;    % Erase peroidisity
x_f(155) = 0;   % Erase peroidisity

x_f(29) = 0;
x_f(141) = 0;

x_f(6) = 0;
x_f(164) = 0;

x_f(8) = 0;
x_f(162) = 0;

x_f(10) = 0;
x_f(160) = 0;


% plot(mag2db(abs(x_f)))

figure
x_t = ifft(x_f);

p = 20;
a = aryule(x_t,p);

freqz(1,a)

figure

plot(x)
hold on
plot(x_t)

figure 
plot(abs(fft(data_mean)))
figure
phi = aryule(x_t,10);

out = 0;
dummy = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = randn(1,168);

% for n = 1:168 % for loop to define x[n] = z[n] + sigma[n-1] + sigma[n-2] .. sigma[n-i] 
%     
%     out(n) = x * phi';
%     dummy(1) = randn(1);
%     
%     for k = 2:length(x)
%         dummy(k) = x(k-1);
%     end
% 
%     x = dummy;
% end
y = filter(10,phi,x);

A = 2820 / (168/2); % Amplitude of cosine peroridicity - A*cos(2*pi*f*t + theta) 
fz = (15/168) ;%2.48*10^-5; %1/(15/168); 
t = (1:1:168);
per1 = A * cos(2*pi*fz*t + theta(1)); % Peoridisity
per2 = A * cos(2*pi*fz*t + theta(2));
per3 = A * cos(2*pi*fz*t + theta(3));
per4 = A * cos(2*pi*fz*t + theta(4));
per5 = A * cos(2*pi*fz*t + theta(5));
per6 = A * cos(2*pi*fz*t + theta(6));



plot(per1+per2+per3+per4+per5+per6+y)
hold on 
plot(data_mean)
figure
plot(abs(fft((per1+per2+per3+per4+per5+per6+y))))
fit(t',data(:,3),'smoothingspline')