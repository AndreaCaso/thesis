clear;
alpha_str_var = linspace(2,20,20);
subj_num = 20;

for subj = 1:subj_num
 for cc = 1:length(alpha_str_var)
  
  initialise;
  alpha_str = alpha_str_var(cc); 
  runP;

  mu(cc,subj) = fit_vector(1);
  sigma(cc,subj) = fit_vector(2);
  tau(cc,subj) = fit_vector(3);
  acc(cc,subj) = mean(Accuracy);
  
 end
end

figure;
subplot(2,2,1);
errorbar(alpha_str_var,mean(mu,2)./max(mean(mu,2))*100, std(mu,1,2)/sqrt(subj_num),'s-');
xlabel('\alpha_{str}', 'FontSize', 10);
ylabel('\mu', 'FontSize', 10);
ylim([min(min(mu))./max(mean(mu,2))*100 105]);

subplot(2,2,2);
errorbar(alpha_str_var,mean(sigma,2)./max(mean(sigma,2))*100, std(sigma,1,2)/sqrt(subj_num),'s-');
xlabel('\alpha_{str}', 'FontSize', 10);
ylabel('\sigma', 'FontSize', 10);
ylim([min(min(sigma))./max(mean(sigma,2))*100 105]);

subplot(2,2,3);
errorbar(alpha_str_var,mean(tau,2)./max(mean(tau,2))*100, std(tau,1,2)/sqrt(subj_num),'s-');
xlabel('\alpha_{str}', 'FontSize', 10);
ylabel('\tau', 'FontSize', 10);
ylim([min(min(tau))./max(mean(tau,2))*100 105]);

subplot(2,2,4);
errorbar(alpha_str_var, mean(acc,2)./max(mean(acc,2))*100, std(acc,1,2)/sqrt(subj_num),'s-');
xlabel('\beta_{str}', 'FontSize', 10);
ylabel('Accuracy', 'FontSize', 10);
ylim([min(min(acc))./max(mean(acc,2))*100 105]);