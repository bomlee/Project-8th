clc; clear all; close all;

%%
data = load('Step_filter')

four = data.Outputs.signals.values;
four = four(341:length(four),:);

time(1) = 0;
for n = 2:length(four)
    time(n) = time(n-1) + 1/20;
end


plot(time,four)
grid on 
xlabel('time [s]')
ylabel('Pressure [Bar]')

