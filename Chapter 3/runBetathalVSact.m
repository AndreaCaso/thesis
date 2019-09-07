% run beta_thal -0.5 to 2 (by 0.05) against SMA activation
   
% beta_thal: THALAMUS saturation threshold 
clear; clc; 
beta_sma  = 0.5*(ones(1,6));
beta_str  = 0.4*(ones(1,6));
beta_thal = 0.5*(ones(1,6));
alpha_str = 5;
alpha_thal = 6;

beta_thal_var = -0.5:0.05:2;

for cc = 1:length(beta_thal_var)

beta_thal = beta_thal_var(cc)*(ones(1,6));  
runP;
o_SMAtot = [o_SMA(1,:) o_SMA(2,:) o_SMA(3,:)];
actMean(cc) = mean(o_SMAtot(o_SMAtot>0.1));
actMedian(cc) = median(o_SMAtot(o_SMAtot>0.1));
actMad(cc) = mad(o_SMAtot(o_SMAtot>0.1));
actStd(cc) = std(o_SMAtot(o_SMAtot>0.1));

end

figure;
subplot(2,1,1);
plot(beta_thal_var,actMean);
xlabel('\beta_{thal}');
ylabel('Average Activation (SMA)');
hold on; plot(beta_thal_var,actMedian);
legend('Mean','Median');

subplot(2,1,2);
plot(beta_thal_var,actStd);
xlabel('\beta_{thal}');
ylabel('St. Dev. Activation (SMA)');
