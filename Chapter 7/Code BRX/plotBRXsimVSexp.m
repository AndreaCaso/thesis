% Plots simulation and experimental data one next to the other
% Gets the structures with performances as inputs 
% Input Old and Young Separately!
% plotBRXsimVSexp(BRX_SIM_YOUNG_indivStats,BRX_indivStats([BRX_indivStats.Age]>=60))

function plotBRXsimVSexp(BRX_SIM,BRX_EXP) 

 mean_matrix = [nanmean([BRX_EXP.TE]), nanmean([BRX_EXP.PRE]), nanmean([BRX_EXP.PRU]), nanmean([BRX_SIM.PRSRE]); nanmean([BRX_SIM.TE]),nanmean([BRX_SIM.PRE]), nanmean([BRX_SIM.PRU]), nanmean([BRX_SIM.PRSRE])]';
 error_matrix = [nanstd([BRX_EXP.TE]), nanstd([BRX_EXP.PRE]), nanstd([BRX_EXP.PRU]), nanstd([BRX_SIM.PRSRE]); nanstd([BRX_SIM.TE]), nanstd([BRX_SIM.PRE]), nanstd([BRX_SIM.PRU]), nanstd([BRX_SIM.PRSRE])]';
 barwitherr(error_matrix,mean_matrix);
  
 set(gca,'XTickLabel',{'TE','PRE','PRU','PRSRE'});
 legend('Exp','Sim')
 BRX_EXP(isnan([BRX_EXP.TE])) = [];
 gof = goodnessOfFit([[BRX_SIM.TE]',[BRX_SIM.PRE]',[BRX_SIM.PRU]',[BRX_SIM.PRSRE]'],[[BRX_EXP.TE]',[BRX_EXP.PRE]',[BRX_EXP.PRU]',[BRX_EXP.PRSRE]'],'MSE');
 fprintf('Goodness of fit for TE,PE,SL3: %f \n', gof)

 
end