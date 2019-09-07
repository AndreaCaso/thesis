% Plots simulation and experimental data one next to the other
% Gets the structures with performances as inputs 
% Input Old and Young Separately!
% plotWCSTsimVSexp(WCST_SIM_YOUNG_indivStats,WCST_indivStats([WCST_indivStats.Age]>=60))

function plotWCSTsimVSexp(WCST_SIM,WCST_EXP) 
 
 mean_matrix = [mean([WCST_EXP.TE]), mean([WCST_EXP.PE]), mean([WCST_EXP.SL3]); mean([WCST_SIM.TE]), mean([WCST_SIM.PE]), mean([WCST_SIM.SL3]) ]';
 error_matrix = [std([WCST_EXP.TE]), std([WCST_EXP.PE]), std([WCST_EXP.SL3]); std([WCST_SIM.TE]), std([WCST_SIM.PE]), std([WCST_SIM.SL3]) ]';
 
 barwitherr(error_matrix,mean_matrix);
  
 set(gca,'XTickLabel',{'TE','PE','SL'})
 legend('Exp','Sim')
 
 try
      gof = goodnessOfFit([[WCST_SIM.TE]',[WCST_SIM.PE]',[WCST_SIM.SL3]'],[[WCST_EXP.TE]',[WCST_EXP.PE]',[WCST_EXP.SL3]'],'MSE');
 catch
      gof = goodnessOfFit([[WCST_SIM.TE]',[WCST_SIM.PE]',[WCST_SIM.SL3]'],[[WCST_EXP.TE],[WCST_EXP.PE],[WCST_EXP.SL3]],'MSE');
 end
 fprintf('Goodness of fit for TE,PE,SL3: %f \n', gof);

end