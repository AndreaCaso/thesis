%% Plot channels 1, 2, 3 only

beta_sma  = 0.6*(ones(1,6)); %default is 0.5
beta_str  = 0.5*(ones(1,6)); %default is 0.4

%beta_str(1) = 0.10; beta_str(2) = 0.50; beta_str(3) = 0.90;
%beta_sma(1) = 0.10; beta_sma(2) = 0.10; beta_sma(3) = 0.10;

beta_thal = 0.4*(ones(1,6)); %default is 0.5

alpha_str = 4; %default is 5
alpha_sma = 8; %5

alpha_thal = 4; %default is 6
threshold = 0.5*ones(1,3); 

runP;

figure;

nn = 1; 
for sb = 1:3
    
    subplot(3,1,nn);
    hold on;  
    plot(1:size(o_SMA,2), o_SMA(sb,:), 'LineWidth', 3);
    plot(1:size(o_ENV,2), o_ENV(sb,:), 'r--');
    plot(1:size(o_THAL,2), o_THAL(sb,:), 'c--');
    %title(['\beta_{str}=', num2str(beta_str(sb),2), subTitleSchema(sb)], 'FontSize', 10);
    title(['\beta_{sma} = ', num2str(beta_sma(sb),2), 'and \beta_{str} = ', num2str(beta_str(sb),2), subTitleSchema(sb)], 'FontSize', 10);
    ylim([-0.1 1.1]);
    nn = nn+1;
    
    for ii = 2:length(o_SMA(sb,:)) - 1
    
    hold on;
    lgt = (ii); % sampled 
    
    if o_SMA(sb,ii) > threshold(sb)
          
%         ha = area([lgt - 1 lgt + 1], [1.1 1.1],'LineStyle','none','FaceColor',[1 0.1 0.1]);
%         alpha(0.05);    % Transparent area
    
    end
    
    end

end

