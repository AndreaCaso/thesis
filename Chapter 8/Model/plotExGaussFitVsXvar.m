% The script plot from the structure produced with genExGaussFitVsXvar
% Usage example:
% plotExGaussFitVsXvar(exgauss_str, '\epsilon_{str}');
% plotExGaussFitVsXvar(exgauss_ctx, '\epsilon_{ctx}');

function plotExGaussFitVsXvar(exgauss, x_var_label)

all_mean = mean(exgauss.mu_sigma_tau,3); % mean across trials
all_se = std(exgauss.mu_sigma_tau,1,3)/sqrt(size(exgauss,3)); % SE across trials

mu_mean = all_mean(:,1)';
mu_se = all_se(:,1)';
sigma_mean = all_mean(:,2)';
sigma_se = all_se(:,2)';
tau_mean = all_mean(:,3)';
tau_se = all_se(:,3)';

hold on;

subplot(3,1,1)
plot(exgauss.x_range,mu_mean);
errorbar(exgauss.x_range,mu_mean,mu_se);
ylabel('\mu');
xlabel(x_var_label);

subplot(3,1,2)
plot(exgauss.x_range,sigma_mean);
errorbar(exgauss.x_range,sigma_mean,sigma_se);
ylabel('\sigma');
xlabel(x_var_label);

subplot(3,1,3)
plot(exgauss.x_range,tau_mean);
errorbar(exgauss.x_range,tau_mean,tau_se);
ylabel('\tau');
xlabel(x_var_label);

end