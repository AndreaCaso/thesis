% run beta_str -0.25 to 1.5 (by 0.01) against SMA activation

% beta_str: STRIATUM saturation threshold 
clear; clc; 
beta_sma  = 0.5*(ones(1,6));
beta_str  = 0.4*(ones(1,6));
beta_thal = 0.5*(ones(1,6));
alpha_thal = 6; %6
alpha_str = 5;

alpha_thal_var = 0:0.5:10;

for cc = 1:length(alpha_thal_var)

alpha_thal = alpha_thal_var(cc);  

runP;

o_SMAtot = [o_SMA(1,:) o_SMA(2,:) o_SMA(3,:)];
actMean(cc) = mean(o_SMAtot(o_SMAtot > 0.1));
actMedian(cc) = median(o_SMAtot(o_SMAtot > 0.1));
actMad(cc) = mad(o_SMAtot(o_SMAtot > 0.1));
actStd(cc) = std(o_SMAtot(o_SMAtot > 0.1));

end

figure;
subplot(2,1,1);
plot(alpha_thal_var,actMean);
xlabel('\alpha_{thal}');
ylabel('Average Activation (SMA)');
hold on; plot(alpha_thal_var,actMedian);
legend('Mean','Median');

subplot(2,1,2);
plot(alpha_thal_var,actStd);
xlabel('\alpha_{thal}');
ylabel('St. Dev. Activation (SMA)');
