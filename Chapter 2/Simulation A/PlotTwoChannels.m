%% Plot Channels
% make sure that the output from Simulink
% are in the TimeSeries format

warning('OFF')
load('Simulation1 Variables.mat');
% Reset parameters

G_Lin = 5;
A_Lin = 5;
DAmp = 0.5;
w_e = 1; w_inh = 0.10; w_minus = 1.05; w_plus = 1;
w_t = 1; w_s = 1; CHNoise = 1e-4;

FontSize = 12;
figure;

subplot(2,1,1);
hold on;
sim('Simulation2_1.slx',[]);
% Solid line: Output
plot(CH1_OUT.Time, CH1_OUT.Data,'b','LineWidth',1.7);
% Dashed line: Input
plot(CH1_IN.Time, CH1_IN.Data,'b--','LineWidth',0.5);
ylim([-0.1 1.1]);
title('Channel 1','FontSize', FontSize);
xlabel('Time','FontSize', FontSize);
ylabel('Inhibition','FontSize', FontSize);

subplot(2,1,2);
hold on;
plot(CH2_OUT.Time, CH2_OUT.Data,'r','LineWidth',1.5);
plot(CH2_IN.Time, CH2_IN.Data,'r--');
ylim([-0.1 1.1]);
title('Channel 2','FontSize', FontSize);
xlabel('Time','FontSize', FontSize);
ylabel('Inhibition','FontSize', FontSize);
