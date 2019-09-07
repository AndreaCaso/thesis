%% Plot Channels
% make sure that the output from Simulin4
% are in the TimeSeries format
%clear;
load('Extension 1 Variables.mat');
%w_e = 0.8; w_g = 0.8; w_plus =  0.8; w_t = 1;
%w_inh = 0.03; 
beta_str = 0.7; 
alpha_str = 5.33;
threshold = 0.5;
CHNoise = 1e-10;
%load('Simulation1 Variables.mat')

highlight = 0;
clc;
highlight = input('Highlight areas above the threshold(Y/N) ? ','s');
if upper(highlight) == 'Y'
    highlight = 1;
else
    highlight = 0;
end

f_sampl = 1/0.1;
warning('OFF')
sim('ExtensionSimulation1var_5.slx',[])
fprintf('Model Simulated \n')
FontSize = 14;
figure;  

for nn = 1:5
    
%% Subplot

subplot(5,1,nn);
hold on;
fprintf('Channel %d ... ',nn)
plot(CH_IN.Time, CH_IN.Data(:,nn),'--','Color',[0 0.4 0],'LineWidth',2);
plot(CH_OUT.Time, CH_OUT.Data(:,nn),'b','LineWidth',2);

ylim([-0.1 1.1]);
title(['CH', num2str(nn)],'FontSize', FontSize);
xlabel('Time','FontSize', FontSize);
ylabel('Act.','FontSize', FontSize);

%% Colouring the area
if highlight == 1
    lengthArea = length(CH_OUT.Time);
for ii = 2:lengthArea-1
    lgt = (ii-1)/f_sampl; % sampled 
    if CH_OUT.Data(ii,nn) < threshold
       ha = area([lgt - 0.2 lgt + 0.2], [1.1 1.1],'LineStyle','none','FaceColor',[1 0.1 0.1]);
       alpha(0.50);    % Transparent area
    end
end

end
fprintf('completed\n')
hold off

clear lengthArea;
clear ii;
clear lgt;

%% Calculate selectivity 1 - #selected channels / #active channels in
selectivity = [];

for tt = 1:size(CH_IN.Time,1)
    
    active_channels_in = length(find(CH_IN.Data(tt,:)>threshold)); % 
    selected_channels = length(find(CH_OUT.Data(tt,:)<threshold));
    
    selectivity(tt) = 1 - selected_channels/active_channels_in;
    
end

end

