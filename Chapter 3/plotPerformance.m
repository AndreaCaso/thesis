% The following script plots the performance structure from runChannels
function plotPerformance(performance)
x_value = arrayfun(@(x) mean(x.bg_mod),performance);   %straighten x-axis values

mu_value = arrayfun(@(x) mean(x.mu),performance); 
sigma_value = arrayfun(@(x) mean(x.sigma),performance); 
tau_value = arrayfun(@(x) mean(x.tau),performance);

mu_error = arrayfun(@(x) std(x.mu),performance); 
sigma_error = arrayfun(@(x) std(x.sigma),performance); 
tau_error = arrayfun(@(x) std(x.tau),performance);

accuracy = arrayfun(@(x) mean(x.MeanAcc),performance);
medianRT = arrayfun(@(x) mean(x.medianRT),performance);
win_out =  arrayfun(@(x) mean(x.win_out),performance);
win_out_std =  arrayfun(@(x) std(x.win_out),performance);

fit_value = arrayfun(@(x) mean(x.chi),performance);
hold on;
p1 = plot(x_value,mu_value,'r');
p2 = plot(x_value,sigma_value,'b');
p3 = plot(x_value,tau_value,'g');
errorbar(x_value,mu_value,mu_error,'r');
errorbar(x_value,sigma_value,sigma_error,'b');
errorbar(x_value,tau_value,tau_error,'g');
legend([p1 p2 p3],{'\mu','\sigma','\tau'});
xlabel('\beta_{str}');

figure;
plot(x_value,accuracy);
ylim([0 1.1])
%plot(x_value,fit_value);
%plot(x_value,medianRT);
plot(x_value,win_out);
errorbar(x_value,win_out,win_out_std);
xlabel('\beta_{str}');
ylabel('Mean Global Channel Activation');c

end