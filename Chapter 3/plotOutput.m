%% Plot action schemas (parietal/premotor) activation values

fig = figure;
tabgp = uitabgroup(fig); % Creates a tab group in the figure
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
%% Tab 1
tab1 = uitab(tabgp,'Title','Schemas 1,2,3');
axes('Parent',tab1); %Assigns the tab to the parent window

nn = 1; 
for sb = 1:3
    
    subplot(3,1,nn);
    hold on;
    plot(1:size(o_SMA,2), o_SMA(sb,:), 'b', 'LineWidth', 3);
    plot(1:size(o_ENV,2), o_ENV(sb,:), 'r--');
    plot(1:size(o_THAL,2), o_THAL(sb,:), 'c--');
    title(['\beta_{str}=', num2str(beta_str(sb),2), subTitleSchema(sb)], 'FontSize', 10);
    ylim([-1.1 1.1]);
    nn = nn+1;
    
end

%% Tab 2
tab2 = uitab(tabgp,'Title','Schemas 4,5,6');
axes('Parent',tab2);
%{
nn = 1;
for sb = 4:6
    
    subplot(3,1,nn);
    hold on;
    plot(1:size(o_SMA,2), o_SMA(sb,:), 'LineWidth', 3);
    plot(1:size(o_ENV,2), o_ENV(sb,:), 'r--');
    title(['\beta_{str}=', num2str(beta_str(sb),2), subTitleSchema(sb)], 'FontSize', 10);
    ylim([-1.1 1.1]);
    nn = nn + 1;
    
end

%% Action tab
tabA = uitab(tabgp,'Title','Actions performed');
%axes('Parent',tabA); %Assigns the tab to the parent window

mTextBox = uicontrol('style','text'); % User interface TextBox
set(mTextBox,'String','');

%}
