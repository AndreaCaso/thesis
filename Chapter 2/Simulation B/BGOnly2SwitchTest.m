clc;
tic;
threshold = 0.6; % 0.6 is default
f_sampl = 1/0.1;
colors = ['k';'g';'b';'c';'r'];

warning('OFF')

figure;


for bb = 1:5
    
    beta_str_ch = 0.5*ones(1,5) ;

sim('BGOnly2.slx',[]);

corticalSelected = zeros(length(BG_OUT.Time),5);
basalSelected = zeros(length(BG_OUT.Time),5);

%% Calculate average selected channel    
for ii = 1:length(BG_OUT.Time)
    
    for nn = 1:5
        
        if BG_IN.Data(ii,nn) >= (threshold) 
            corticalSelected(ii,nn) = corticalSelected(ii,nn) + 1;
        end
    
        if BG_OUT.Data(ii,nn) <= (threshold) 
            basalSelected(ii,nn) = basalSelected(ii,nn) + 1;
        end
        
    end
end


hold on;

switchRatio = zeros(length(BG_OUT.Time),5);
switchRatio(:,bb) = sum(basalSelected,2)./sum(corticalSelected,2);

%idx = isfinite(BG_OUT.Time) & isfinite(switchRatio(:,bb)); % excluding non-finite ratios
%fitSwitchRatio = fit(BG_OUT.Time(idx), switchRatio(idx,bb),'poly2');

plot(BG_OUT.Time, switchRatio(:,bb),'b');

%fitPlot = plot(fitSwitchRatio,colors(bb));
%set(fitPlot, 'LineWidth',3);
%set(fitPlot, 'LineStyle',':');
%textPlot = ['\beta_{str} = ',num2str(0.2*(bb - 0.5))];
%text(37-bb, 5.5-bb, textPlot, 'Color', 'k');

end

xlabel('Time(secs)');
ylabel('Channel selectivity');
%ylim([-1 8]);
%xlim([30 60]);
%hLegend = legend('');
%set(hLegend,'visible','off')

clear ii; clear nn;
clear threshold;
clear f_sampl;

elapsedTimeSec = toc;
elapsedTimeMin = elapsedTimeSec/60;
fprintf('Elapsed time: %1.2f secs or %1.2f min \n',elapsedTimeSec,elapsedTimeMin)

clear elapsedTimeSec; 
clear elapsedTimeMin;