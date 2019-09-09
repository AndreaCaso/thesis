% run beta_str -0.25 to 1.5 (by 0.01) against SMA activation

beta_str_var = 0:0.1:1.0;

for cc = 1:length(beta_str_var)

beta_str = beta_str_var(cc)*(ones(1,6));  

runP;

o_difftot = [o_ENV(1,:) - o_SMA(1,:), o_ENV(2,:) - o_SMA(2,:), o_ENV(3,:) - o_SMA(3,:)];
o_difftot = abs(o_difftot);

actMean(cc) = mean(o_difftot(o_difftot  > 0.1));
%actMedian(cc) = median(o_difftot);

actStd(cc) = std(o_difftot(o_difftot  > 0.1)); 

end

figure;
subplot(2,1,1);
plot(beta_str_var, actMean);
xlabel('\beta_{str}', 'FontSize', 10);
ylabel('Mean | o_{sma} - o_{ext} |', 'FontSize', 10);

subplot(2,1,2);
plot(beta_str_var,actStd);
xlabel('\beta_{str}', 'FontSize', 10);
ylabel('St.dev | o_{sma} - o_{ext} |', 'FontSize', 10);
