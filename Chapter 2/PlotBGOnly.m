%% Plot BGOnly
% make sure that the output from Simulink
% are in the TimeSeries format

clc;
tic;
threshold = 0.6; % 0.6 is default
f_sampl = 1/0.1;
FontSize = 14;
warning('OFF')

sim('BGOnly.slx',[])
fprintf('Model Simulated \n')
figure;  

h = waitbar(0,'Wait...');
for nn = 1:5
    
%% Subplot

subplot(5,1,nn);
hold on;
fprintf('Channel %d ... ',nn)
plot(BG_IN.Time, BG_IN.Data(:,nn),'--','Color',[0 0.4 0],'LineWidth',2);
plot(BG_OUT.Time, BG_OUT.Data(:,nn),'b','LineWidth',2);

ylim([-0.1 1.1]);
title(['Channel', num2str(nn)],'FontSize', FontSize);
xlabel('Time','FontSize', FontSize);
ylabel('Activation','FontSize', FontSize);

for ii = 2:length(BG_OUT.Time)-1
    
    %lgt = (ii-1)/f_sampl; % sampled 
    %if BG_OUT.Data(ii,nn) < threshold
    %    ha = area([lgt - 0.05 lgt + 0.05], [1.1 1.1],'LineStyle','none','FaceColor',[1 0.1 0.1]);
    %    alpha(0.05);    % Transparent area
    %end
    
waitbar(nn*ii / ((length(BG_OUT.Time))*5), h);

end

fprintf('completed\n');
hold off;

end

hold off

clear lengthArea; clear ii;
clear lgt; clear threshold;
clear f_sampl;

elapsedTimeSec = toc;
elapsedTimeMin = elapsedTimeSec/60;
fprintf('Elapsed time: %1.2f secs or %1.2f min \n',elapsedTimeSec,elapsedTimeMin)

delete(h) ;
clear elapsedTimeSec; 
clear elapsedTimeMin;
