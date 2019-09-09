%% Plot action schemas (parietal/premotor) activation values

fig = figure;
tabgp = uitabgroup(fig); % Creates a tab group in the figure
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
%% Tab 1: Cognitive schemas (PFC)
tab1 = uitab(tabgp,'Title','Cognitive schemas (PFC)');
axs = axes('Parent',tab1); %Assigns the tab to the parent window
%axs.XTick = cumsum(decCounterTot);

nn = 1; 
for sb = 1:3
    
    subplot(3,1,nn);
    hold on;
   % grid;
    plot(1:size(o_PFC,2), o_PFC(sb,:), 'LineWidth', 3);
    plot(1:size(o_EXT_PFC,2), o_EXT_PFC(sb,:), 'r--', 'LineWidth', 3);
    plot(1:size(o_THAL_PFC,2), o_THAL_PFC(sb,:), 'c--');
    title(['\beta_{str}=', num2str(beta_str_pfc(sb),2), subTitleSchemaPFC(sb)], 'FontSize', 10);
    % Plot vertical lines each decMakInt timesteps (trial)
   
    %{
    hold on;
    for idx = cumsum(decCounterTot)
        plot([idx idx], [-2 2], 'Color', 'k', 'LineWidth', 0.8);
    end
    %}
    
    ylim([-0.1 1.1]);
    nn = nn+1;
    
end

%%{
%% Tab 1: Motor schemas (SMA to M1)
tab2 = uitab(tabgp,'Title','Motor schemas (SMA to M1)');
axes('Parent',tab2); %Assigns the tab to the parent window

nn = 1; 
for sb = 1:4
    
    subplot(4,1,nn);
    hold on;
    grid;
    plot(1:size(o_SMA,2), o_SMA(sb,:), 'LineWidth', 3);
    plot(1:size(o_EXT_SMA,2), o_EXT_SMA(sb,:), 'r--');
    plot(1:size(o_THAL_SMA,2), o_THAL_SMA(sb,:), 'c--');
    title(['\beta_{str}=', num2str(beta_str_sma(sb),2), subTitleSchemaSMA(sb)], 'FontSize', 10);
    
    % Plot vertical lines each 200 timesteps (trial)
  
    hold on;
    for idx = cumsum(decCounterTot)
        plot([idx idx], [-2 2], 'Color', 'k', 'LineWidth', 0.8);
    end
    
    ylim([-0.1 1.1]);
    nn = nn+1;
    
end

%% Action tab
tabA = uitab(tabgp,'Title','Actions performed');
%axes('Parent',tabA); %Assigns the tab to the parent window

mTextBox = uicontrol('style','text'); % User interface: static text box
fileText = fileread('logWCST.txt'); % Save file content in a string
set(mTextBox,'Parent',tabA);
set(mTextBox,'String',fileText); % Print the string in a static box
set(mTextBox,'BackgroundColor',[0 0.5 1]);
set(mTextBox,'Units','normalized');
set(mTextBox,'Position',[3 1 10 1]);

%mTextBoxPosition = get(mTextBox,'Position');

%%}