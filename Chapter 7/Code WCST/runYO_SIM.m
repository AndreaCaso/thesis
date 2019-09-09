
function [RT_Y_corr, RT_Y_incorr, RT_O_corr, RT_O_incorr] = runYO_SIM(tot_trials)

 young_indivStats = runWCSTvar_Set(tot_trials,{'epsilon.eps_str','epsilon.eps_pfc'},{0.1129,0.3042});
 old_indivStats = runWCSTvar_Set(tot_trials,{'epsilon.eps_str','epsilon.eps_pfc'},{0.1028,0.4531});
 
 RT_Y_corr = arrayfun(@(x) median(x.RTcorr), young_indivStats);
 RT_Y_incorr = arrayfun(@(x) median(x.RTincorr), young_indivStats);
 
 RT_O_corr = arrayfun(@(x) median(x.RTcorr), old_indivStats);
 RT_O_incorr = arrayfun(@(x) median(x.RTincorr), old_indivStats);
 
 mean_matrix = [trimmean([RT_Y_corr],10), trimmean([RT_Y_incorr],10); trimmean([RT_O_corr],10), trimmean([RT_O_incorr],10)];
 error_matrix = [nanstd([RT_Y_corr]), nanstd([RT_Y_incorr]); nanstd([RT_O_corr]), nanstd([RT_O_incorr])];

 barwitherr(error_matrix/sqrt(tot_trials),(mean_matrix-420));
 set(gca,'XTickLabel',{'Young','Old'});
 legend('Correct','Incorrect')
 title('RT')