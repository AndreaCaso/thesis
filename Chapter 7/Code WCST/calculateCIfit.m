% Calculate the multidimensional model fit
% by bootstrapping in all the outcome variables
% and calculating the difference between the median.
% Returns mean, confidence interval (95%) for all outcome 
% variables
% e.g. usage: 
% calculateCIfit(WCST_SIM_YOUNG_indivStats,WCST_indivStats([WCST_indivStats.Age]<60));
% calculateCIfit(WCST_SIM_G3of3_indivStats,WCSTclusters_stats{3});

function CIs = calculateCIfit(WCST_SIM,WCST_EXP)

for smp = 1:200000
 diff_TE(smp) = median(randsampleWithRep([WCST_SIM.TE],length([WCST_SIM.TE]))) - median(randsampleWithRep([WCST_EXP.TE],length([WCST_EXP.TE])));
 diff_PE(smp) = median(randsampleWithRep([WCST_SIM.PE],length([WCST_SIM.PE]))) - median(randsampleWithRep([WCST_EXP.PE],length([WCST_EXP.PE])));
 diff_SL3(smp) = median(randsampleWithRep([WCST_SIM.SL3],length([WCST_SIM.SL3]))) - median(randsampleWithRep([WCST_EXP.SL3],length([WCST_EXP.SL3])));
 
 diff_TE(smp) = diff_TE(smp) + 0.01*randn;
 diff_PE(smp) = diff_PE(smp) + 0.01*randn;
 diff_SL3(smp) = diff_SL3(smp) + 0.01*randn;
end

pp = [ (1-.95)/2 , 1- ((1-.95)/2) ];

CIs.TE = [quantile(diff_TE,pp(1)), quantile(diff_TE,pp(2))];
CIs.PE = [quantile(diff_PE,pp(1)), quantile(diff_PE,pp(2))];
CIs.SL3 = [quantile(diff_SL3,pp(1)), quantile(diff_SL3,pp(2))];
means.TE = mean(diff_TE);
means.PE = mean(diff_PE);
means.SL3 = mean(diff_SL3);

fprintf('CI 95 TE: [%1.2f %1.2f], mean: %1.2f \n', CIs.TE(1), CIs.TE(2), means.TE);
fprintf('CI 95 PE: [%1.2f %1.2f], mean: %1.2f \n', CIs.PE(1), CIs.PE(2), means.PE);
fprintf('CI 95 SL3: [%1.2f %1.2f], mean: %1.2f \n', CIs.SL3(1), CIs.SL3(2),means.SL3);

figure;
subplot(3,1,1); histogram(diff_TE);
subplot(3,1,2); histogram(diff_PE);
subplot(3,1,3); histogram(diff_SL3);

end