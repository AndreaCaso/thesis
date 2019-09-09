% run beta_sma 0 to 1.5 (by 0.1) against SMA activation

% beta_sma: SUPPLEMENTARY MOTOR AREA saturation threshold 
clear; clc; 
beta_sma  = 0.5*(ones(1,6)); % 0.5
beta_str  = 0.5*(ones(1,6)); % 0.4
beta_thal = 0.4*(ones(1,6)); % 0.5

alpha_str = 4; % 5
alpha_sma = 8;

alpha_thal = 4; % 6

beta_sma_var = -0.5:0.025:1.5;

for cc = 1:length(beta_sma_var)

beta_sma = beta_sma_var(cc)*(ones(1,6));  

runP;

o_difftot = [o_ENV(1,:) - o_SMA(1,:), o_ENV(2,:) - o_SMA(2,:), o_ENV(3,:) - o_SMA(3,:)];
o_difftot = abs(o_difftot);

actMean(cc) = mean(o_difftot(o_difftot  > 0.1));
%actMedian(cc) = median(o_difftot);

actStd(cc) = std(o_difftot(o_difftot  > 0.1)); 

end

figure;
subplot(2,1,1);
plot(beta_sma_var,actMean);
xlabel('\beta_{sma}', 'FontSize', 10);
ylabel('Mean | o_{sma} - o_{ext} |', 'FontSize', 10);

subplot(2,1,2);
plot(beta_sma_var,actStd);
xlabel('\beta_{sma}', 'FontSize', 10);
ylabel('St.dev | o_{sma} - o_{ext} |', 'FontSize', 10);
