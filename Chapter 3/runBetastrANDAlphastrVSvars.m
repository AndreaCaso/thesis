% run alpha_str 0 to 10 (by 0.1) against SMA activation
% for different beta_str (0.1 to 1.2 by 0.2 steps)

clear; clc; 
%initalisation variables
beta_sma  = 0.5*(ones(1,6));
beta_str  = 0.4*(ones(1,6));
beta_thal = 0.5*(ones(1,6));
alpha_str = 5;
alpha_thal = 6;

% variables that will be manipulated
alpha_str_var = 0:2:10;
beta_str_var = -0.2:0.05:1.1;

for cc1 = 1:length(beta_str_var)
    for cc2 = 1:length(alpha_str_var)

        alpha_str = alpha_str_var(cc2); 
        beta_str = beta_str_var(cc1)*(ones(1,6));

        runP;

        o_SMAtot = [o_SMA(1,:) o_SMA(2,:) o_SMA(3,:)];

        actStd(cc1,cc2) = mean(o_SMAtot(o_SMAtot > 0.1));
        actMad(cc1,cc2) = mad(o_SMAtot(o_SMAtot > 0.1),1);

    end
    
    fprintf('%1.1f percent completed\n', 100*cc1*cc2/(length(beta_str_var)*length(alpha_str_var)));

end

figure;
for subPlotNum = 1:6
    
subplot(3,2,subPlotNum);

plot(beta_str_var,actStd(:,subPlotNum)');
hold on; 
plot(beta_str_var,actMad(:,subPlotNum)');
xlabelStr = ['\beta_{str} for alpha_{str} ', num2str(alpha_str_var(subPlotNum))];
xlabel(xlabelStr);
ylabel('Variation in Activation (SMA)');

legend('St.Dev','Median Abs. Dev.');

end