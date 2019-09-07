%% PlotDopa 

% Examining the effect of 
% dopamine in the inhibition/disinhibition
% of the channel

load('Simulation1 Variables.mat');
G_Lin = 5;
A_Lin = 5;
DAmp = 0.5;
w_e = 1; w_inh = 0.10; w_minus = 1.05; w_plus = 1;
w_t = 1; w_s = 1; CHNoise = 1e-4;

% DA = [0 0.5 1 1.5 2 4]; % Dopamine values analysed
DA = [0.00 1.0 1.5];

for plotNum = 1:length(DA)
    
subplot(length(DA),2,2*plotNum-1) % Channel 1 in the first column
DAmp = DA(plotNum);
simOut = evalc('sim(''Simulation2_1.slx'')');

hold on;
plot(CH1_OUT.Time,CH1_OUT.Data,'b');
plot(CH1_IN.Time,CH1_IN.Data,'--','Color',[0.5,0.1,0.3]);
plot(CH1_IN.Time,0.5*ones(1,length(CH1_IN.Data)),'-.','Color',[0.1 0.1 0.1]);
grid on;
title(['Channel 1 - DA set to ', num2str(DAmp)]);
xlabel('Time');
ylabel('Inhibition');
ylim([-0.1 1.1]);

end

for plotNum = 1:length(DA)
    
subplot(length(DA),2,2*plotNum)
DAmp = DA(plotNum);
simOut = evalc('sim(''Simulation2_1.slx'')');
hold on;
plot(CH2_OUT.Time,CH2_OUT.Data,'b');
plot(CH2_IN.Time,CH2_IN.Data,'--','Color',[0.5,0.1,0.3]);
plot(CH1_IN.Time,0.5*ones(1,length(CH1_IN.Data)),'-.','Color',[0.1 0.1 0.1]);
grid on;
title(['Channel 2 - DA set to ', num2str(DAmp)]);
xlabel('Time');
ylabel('Inhibition');
ylim([-0.1 1.1]);

end
DAmp = 1; % Restore
