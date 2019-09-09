% run alpha_str 0 to 10 (by 0.1) against SMA activation
    
% alpha_str: STRIATUM saturation slope 
clear; clc; 
beta_sma  = 0.5*(ones(1,6)); %default is 0.5
beta_str  = 0.4*(ones(1,6)); %default is 0.4
beta_thal = 0.5*(ones(1,6)); %default is 0.5
alpha_str = 5; %default is 5
alpha_thal = 6; %default is 6

alpha_str_var = 0:0.1:10;

for cc = 1:length(alpha_str_var)

alpha_str = alpha_str_var(cc);  
runP;
o_SMAtot = [o_SMA(1,:) o_SMA(2,:) o_SMA(3,:)];
actMean(cc) = mean(o_SMAtot(o_SMAtot>0.1));
actMedian(cc) = median(o_SMAtot(o_SMAtot>0.1));
actMad(cc) = mad(o_SMAtot(o_SMAtot>0.1));
actStd(cc) = std(o_SMAtot(o_SMAtot>0.1));

end

figure;
subplot(2,1,1);
plot(alpha_str_var,actMean);
xlabel('\alpha_{str}');
ylabel('Average Activation (SMA)');
hold on; plot(alpha_str_var,actMedian);
legend('Mean','Median');

subplot(2,1,2);
plot(alpha_str_var,actStd);
xlabel('\alpha_{str}');
ylabel('St. Dev. Activation (SMA)');
