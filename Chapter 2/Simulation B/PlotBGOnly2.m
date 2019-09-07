%% Plot BGOnly2
% It plots just the first two channels with 
% different values of a chosen variable

%% Input variable

clc; clear;
load('BGOnlyVar.mat');
beta_gpe = 0.3; %0.3
beta_stn = 0.25; %0.25
beta_gpi = 0.30; %0.3
beta_str_values = [0.30,0.5;0.50,0.50;1.00,0.50;1.30,0.50]';
warning('off');

varText = '\beta_{str}';
%valueVar(1) = input('Channel 1 beta_str: ');
%valueVar(2) = input('Channel 2 beta_str: ');
highArea = input('Highlight areas?(Y/N)','s');
plotOrder = [1,5,2,6,3,7,4,8];
threshold = 0.5; % 0.6 is default
f_sampl = 1/0.1;
FontSize = 14;

figure;  

plotN = 1;

%% Loops and plots

tic;

for col = 1:4

        beta_str_ch(1) = beta_str_values(1,col);
        beta_str_ch(2) = beta_str_values(2,col);
        sim('BGOnly2.slx',[])
        fprintf('Model Simulated \n')
        for row = 1:2
        ax(plotN) = subplot(2,4,plotOrder(plotN));
        hold on;
        fprintf('Channel %d ... ',row)
        plot(BG_IN.Time, BG_IN.Data(:,row),'--','Color',[0 0.4 0],'LineWidth',2);
        plot(BG_OUT.Time, BG_OUT.Data(:,row),'b','LineWidth',2);
        ylim([-0.1 1.1]);
        title(['CH', num2str(row), ' ', varText,' = ', num2str(beta_str_ch(row))],'FontSize', FontSize);
        xlabel('Time','FontSize', FontSize);
        ylabel('Activation','FontSize', FontSize);
        plotN = plotN + 1;     
        
        if upper(highArea) == 'Y'
            for ii = 1:length(BG_OUT.Time)
                lgt = (ii-1)/f_sampl; % sampled 
                if BG_OUT.Data(ii,row) < threshold
                    ha = area([lgt - 1 lgt + 1], [1.1 1.1],'LineStyle','none','FaceColor',[1 0.1 0.1]);
                    alpha(0.05);    % Transparent area
                end
            end
        end
        end
        
fprintf('completed\n');
hold off;   
end

linkaxes(ax,'xy');


%% Display elapsed time
clear lengthArea; clear ii;
clear lgt; clear threshold;
clear f_sampl;

elapsedTimeSec = toc;
elapsedTimeMin = elapsedTimeSec/60;
fprintf('Elapsed time: %1.2f secs or %1.2f min \n',elapsedTimeSec,elapsedTimeMin)

clear elapsedTimeSec; 
clear elapsedTimeMin;

%% Restore variables
beta_str_ch = 0.5*ones(1,5);
beta_stn_ch = 0.25*ones(1,5);
beta_gpe_ch = 0.3*ones(1,5);

