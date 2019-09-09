%% Plot Channels
% make sure that the output from Simulink
% are in the TimeSeries format

threshold = 0.4;
f_sampl = 1/0.1;
warning('OFF') 
sim('ExtensionSimulation1var.slx',[])
FontSize = 22;
figure;  

for nn = 1:5
    
%% Subplot

subplot(5,1,nn);
hold on;
plot(CH_OUT.Time, CH_OUT.Data(:,nn),'b','LineWidth',2);
plot(CH_IN.Time, CH_IN.Data(:,nn),'b--','LineWidth',2);
ylim([-0.1 1.1]);
title(['Channel', num2str(nn)],'FontSize', FontSize);
xlabel('Time','FontSize', FontSize);
ylabel('Ch. Inhib.','FontSize', FontSize);

%% Colouring the area

for ii = 2:length(CH_OUT.Time)-1
    
    lgt = (ii-1)/f_sampl; % sampled 
    if CH_OUT.Data(ii,nn) < threshold
        ha = area([lgt - 0.05 lgt + 0.05], [1.5 1.5],'LineStyle','none','FaceColor',[1 0.1 0.1]);
        alpha(0.05);    % Transparent area
    end
end
hold off

end
