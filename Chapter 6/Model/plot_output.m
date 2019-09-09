%% Plot action schemas (parietal/premotor) activation values

fig = figure;
tabgp = uitabgroup(fig); % Creates a tab group in the figure
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
%% Tcab 1: Cognitive schemas (PFC)
tab1 = uitab(tabgp,'Title','Cognitive schemas (PFC)');
axs = axes('Parent',tab1); %Assigns the tab to the parent window
%axs.XTick = cumsum(decCounterTot);

nn = 1; 
for sb = 1:num_rules
    
    subplot(3,2,nn);
    hold on;
    % grid;
    plot(1:size(pfc.o_PFC,2), pfc.o_PFC(sb,:), 'LineWidth', 3);
    %plot(1:size(alpha_pfc_hist,2), alpha_pfc_hist(sb,:)/25, 'r.-', 'LineWidth', 1.5);
    %plot(1:size(satfnc.beta_str_pfc_hist,2), satfnc.beta_str_pfc_hist(sb,:), 'k--','LineWidth', 2);
   
    title(['\beta_{str}=', num2str(satfnc.beta_str_pfc(sb),2), pfc.schema_names(sb)], 'FontSize', 10);
    % Plot vertical lines each decMakInt timesteps (trial)
  
    hold on;
    for idx = counter.tt_trial_num
        plot([idx idx], [-2 2], 'Color', 'k', 'LineWidth', 0.8);
    end
        
    ylim([-0.1 1.1]);
    nn = nn+1;
    
end

%%{
%% Tab 1: Motor schemas (SMA to M1)
tab2 = uitab(tabgp,'Title','Motor schemas (SMA to M1)');
axes('Parent',tab2); %Assigns the tab to the parent window

nn = 1; 
for sb = 1:num_circles
    
    subplot(3,3,nn);
    hold on;
    grid;
    plot(1:size(sma.o_SMA,2), sma.o_SMA(sb,:), 'LineWidth', 3);
    plot(1:size(o_EXT_SMA,2), o_EXT_SMA(sb,:), 'g--');
    plot(1:size(sma.o_THAL_SMA,2), sma.o_THAL_SMA(sb,:), 'b--');
    plot(1:size(sma.w_SMA,2), sma.w_SMA(sb,:), 'c--');
    
    title(['\beta_{str}=', num2str(satfnc.beta_str_sma(sb),2), sma.schema_names(sb)], 'FontSize', 10);
    
    % Plot vertical lines each 200 timesteps (trial)
  
    hold on;
    for idx = counter.tt_trial_num
        plot([idx idx], [-2 2], 'Color', 'k', 'LineWidth', 0.8);
    end
    
    ylim([-0.1 1.1]);
    nn = nn+1;
    
end
%%}