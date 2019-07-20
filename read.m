clear all
close all
clc

f = 10; %Compression rate
series_1 = xlsread('Baseline3S.xlsx'); series_1 = series_1(1:f:end,:);
series_2 = xlsread('Baseline5S.xlsx'); series_2 = series_2(1:f:end,:);
t1 = series_1(:,1); t2 = series_2(:,1);
t_sum = sum(t1 - t2);
if t_sum == 0
    disp('Time axis OK')
end

i = 6;
finish = 1955;
max = [max(series_1(:,i)) max(series_2(:,i))];
signal_norm = zscore([series_1(:,i)/max(1) series_2(:,i)/max(2)]);
start = 392;
signal_env = envelope(signal_norm(start:finish,:));
env_norm =  mat2gray(signal_env);

%corr_coeff = corrcoef(series_1(start:finish,i),series_2(start:finish,i+1))

fig = plot(t1(start:finish),env_norm,'LineWidth',3)
%fig = plot(t1,[series_1(:,i) series_2(:,i+1)],'LineWidth',2)
fig = gcf; fig.Color = [1 1 1]; fig.Position = [0, 100, 1280, 740];
xlim([0 300])
ylim([0 1])
grid on
grid(gca,'minor')
legend('Scenario 1A','Scenario 1B');
n = 36;
set(gca,'fontsize',n)
xlabel('Time [µs]','FontSize',n) ; ylabel('Normmalized Amplitude','FontSize',n);
title('Sensor Location: 36|44 cm')