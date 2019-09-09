%% Plot Channels
% make sure that the output from Simulink
% are in the TimeSeries format
highlight = 0;
clc;
highlight = input('Highlight areas above the threshold(Y/N) ? ','s');
if highlight == 'Y'
    highlight = 1;
else
    highlight = 0;
end

threshold = 0.6;
f_sampl = 1/0.1;
warning('OFF')
sim('ExtensionSimulation2varDISC.slx',[])
fprintf('Model Simulated \n')
FontSize = 14;
figure;  


for nn = 1:5
    
%% Subplot

subplot(5,1,nn);
hold on;
fprintf('Channel %d ... ',nn)
plot(PFC_IN.Time, PFC_IN.Data(:,nn),'--','Color',[0 0.4 0],'LineWidth',2);
plot(CH_OUT.Time, CH_OUT.Data(:,nn),'b','LineWidth',2);

ylim([-0.1 1.1]);
title(['Channel', num2str(nn)],'FontSize', FontSize);
xlabel('Time','FontSize', FontSize);
ylabel('Activation','FontSize', FontSize);

%% Colouring the area
if highlight == 1;
    lengthArea = length(CH_OUT.Time);
for ii = 2:lengthArea-1
    lgt = (ii-1)/f_sampl; % sampled 
    if CH_OUT.Data(ii,nn) >= threshold
       ha = area([lgt - 0.2 lgt + 0.2], [1.1 1.1],'LineStyle','none','FaceColor',[1 0.1 0.1]);
       alpha(0.10);    % Transparent area
    end
end

end
fprintf('completed\n')
hold off

clear lengthArea;
clear ii;
clear lgt;

end
