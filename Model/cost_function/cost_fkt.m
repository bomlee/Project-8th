clear all;
close all;
clc;
%% Preparing data for Feedback coeficients - LN stochastic p. 28

data = load('data.csv'); % Data
data_mean = data(:,3) - mean(data(:,3)); % Mean substracted from data 

atc = autocorr(data_mean); % Autocorrelation of data
 
y_gamma = atc(2:length(atc)) % Used in Yule walker 
Gamma = toeplitz(atc(1:length(atc)-1)); % Used in Yule walker

sigma = inv(Gamma)*y_gamma; % Feedback coeificients for AR(20)

%% 

z = randn(20,1); % White noise input

x = z % AR process
dummy = ones(20,1); % Storage

for n = 1:200
    
    out(n) = x'*sigma
    
    dummy(1) = randn(1);
    for k = 2:20
        dummy(k) = x(k-1);
    end
    x = dummy
    
    
end

plot(data(:,3))
hold on
plot(out)
    

%%
close all
f = linspace(0,1,length(data(:,3)));
x = data_mean;
x_f = fft(x);

% By visual inspection. 17, 177
%x_f(17) = 0
%x_f(177) = 0
plot(mag2db(abs(x_f)))

figure
x_t = ifft(x_f);

p = 20;
a = aryule(x_t,p);

freqz(1,a)




figure


plot(x)
hold on
plot(x_t)


