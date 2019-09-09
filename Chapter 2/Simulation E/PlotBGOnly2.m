%% Plot BGOnly2
% It plots just the first two channels with 
% different values of a chosen variable

%% Input variable

clc; clear;
load('BGOnlyVar.mat');
warning('off');
fprintf('Choose between the variables beta_str, beta_stn, beta_gpe\n')
inpVar = input('Please specifiy the variable: ','s');
valueVar(1,:) = input('Please specifiy three values (e.g. [0.3 0.5 1.1]): ');
highArea = input('Highlight areas?(Y/N)','s');

threshold = 0.6; % 0.6 is default
f_sampl = 1/0.1;
FontSize = 14;

figure;  

plotN = 1;

%% Loops and plots

tic;
for cc = 1:2
for bb = 1:3
        
        % Only channel 1 
        switch inpVar
        case 'beta_str' 
            beta_str_ch(1) = valueVar(1,bb); 
            valueVar(2,bb) = beta_str_ch(2);
            varText = '\beta_{str}';
        case 'beta_stn' 
            beta_stn_ch(1) = valueVar(1,bb);
            valueVar(2,bb) = beta_stn_ch(2);
            varText = '\beta_{stn}';
        case 'beta_gpe'
            beta_gpe_ch(1) = valueVar(1,bb);
            valueVar(2,bb) = beta_gpe_ch(2);
            varText = '\beta_{gpe}';
        otherwise
        error('Invalid variable');
        end
        
        sim('BGOnly2.slx',[])
        fprintf('Model Simulated \n')
        subplot(2,3,plotN);
        hold on;
        fprintf('Channel %d ... ',cc)
        plot(BG_IN.Time, BG_IN.Data(:,cc),'--','Color',[0 0.4 0],'LineWidth',2);
        plot(BG_OUT.Time, BG_OUT.Data(:,cc),'b','LineWidth',2);

        ylim([-0.1 1.1]);
    
        title(['Channel', num2str(cc), varText,' = ', num2str(valueVar(cc,bb))],'FontSize', FontSize);
   
        xlabel('Time','FontSize', FontSize);
        ylabel('Activation','FontSize', FontSize);

        if highArea == 'Y'
            for ii = 1:length(BG_OUT.Time)
                lgt = (ii-1)/f_sampl; % sampled 
                if BG_OUT.Data(ii,cc) < threshold
                    ha = area([lgt - 1 lgt + 1], [1.1 1.1],'LineStyle','none','FaceColor',[1 0.1 0.1]);
                    alpha(0.05);    % Transparent area
                end
            end
        end

fprintf('completed\n');
hold off;
plotN = plotN + 1;
end
end

hold off


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

