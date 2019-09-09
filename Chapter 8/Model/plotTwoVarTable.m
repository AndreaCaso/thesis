%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Usage example:

% Threshold_Epspfc

% plotTwoVarTable('mean',{'\theta_{d}','\epsilon_{pfc}'},{first_var_v,second_var_v},{'RT','\mu','\sigma','\tau'},{Threshold_Epspfc.RT, Threshold_Epspfc.exgauss_mu, Threshold_Epspfc.exgauss_sigma, Threshold_Epspfc.exgauss_tau},{});
% plotTwoVarTable('mean',{'\theta_{d}','\epsilon_{pfc}'},{first_var_v,second_var_v},{'LL','\mu','\sigma','\tau'},{Threshold_Epspfc.LL, Threshold_Epspfc.exgauss_mu, Threshold_Epspfc.exgauss_sigma, Threshold_Epspfc.exgauss_tau},{});
% plotTwoVarTable('mean',{'\theta_{d}','\epsilon_{pfc}'},{first_var_v,second_var_v},{'CC','TE','PE','SL'},{Threshold_Epspfc.CC,Threshold_Epspfc.TE, Threshold_Epspfc.PE, Threshold_Epspfc.SL3},{});

% Eps_str_pfc

% plotTwoVarTable('mean',{'\epsilon_{str}','\epsilon_{pfc}'},{first_var_v,second_var_v},{'RT','\mu','\sigma','\tau'},{Eps_str_pfc.RT, Eps_str_pfc.exgauss_mu, Eps_str_pfc.exgauss_sigma, Eps_str_pfc.exgauss_tau},{});
% plotTwoVarTable('mean',{'\epsilon_{str}','\epsilon_{pfc}'},{first_var_v,second_var_v},{'CC','TE','PE','SL'},{Eps_str_pfc.CC, Eps_str_pfc.TE, Eps_str_pfc.PE, Eps_str_pfc.SL3},{});

% VarThr_Pfc

% plotTwoVarTable('mean_prop',{'\sigma_{\theta}','\epsilon_{pfc}'},{varThr_v2,epspfc_v_3},{'MISS','TE','PE','SL'},{VarThr_Pfc.MISS, VarThr_Pfc.TE, VarThr_Pfc.PE, VarThr_Pfc.SL3},{});
% plotTwoVarTable('mean_minmax',{'\sigma_{\theta}','\epsilon_{pfc}'},{varThr_v2,epspfc_v_3},{'RT_{DR}','RT_{D}','\sigma','\tau'},{VarThr_Pfc.RTdiff_range, VarThr_Pfc.RTdiff, VarThr_Pfc.exgauss_sigma, VarThr_Pfc.exgauss_tau},{});
% plotTwoVarTable('mean',{'\sigma_{\theta}','\epsilon_{pfc}'},{varThr_v2,epspfc_v},{'RT','\mu','\sigma','\tau'},{VarThr_Pfc.RT, VarThr_Pfc.exgauss_mu, VarThr_Pfc.exgauss_sigma, VarThr_Pfc.exgauss_tau},{});

% VarThr_Pfc_untimed

% plotTwoVarTable('mean_norm',{'\sigma_{\theta}','\epsilon_{pfc}'},{varThr_v2,epspfc_v_2},{'RT_{DR}','\mu','\sigma','\tau'},{VarThr_untimed.RTdiff_range, VarThr_untimed.exgauss_mu, VarThr_untimed.exgauss_sigma, VarThr_untimed.exgauss_tau},{});
% plotTwoVarTable('mean_prop',{'\sigma_{\theta}','\epsilon_{pfc}'},{varThr_v2,epspfc_v_2},{'MISS','TE','PE','SL'},{VarThr_untimed.MISS, VarThr_untimed.TE, VarThr_untimed.PE, VarThr_untimed.SL3},{});

% ExtNoise_Pfc

% plotTwoVarTable('mean_prop',{'o_{ext}','\epsilon_{pfc}'},{extpfc_v,epspfc_v_3},{'MISS','TE','PE','SL'},{ExtNoise_Pfc.MISS, ExtNoise_Pfc.TE, ExtNoise_Pfc.PE, ExtNoise_Pfc.SL3},{});
% plotTwoVarTable('mean_minmax',{'o_{ext}','\epsilon_{pfc}'},{extpfc_v,epspfc_v_3},{'RT_{DR}','RT_{D}','\sigma','\tau'},{ExtNoise_Pfc.RTdiff_range, ExtNoise_Pfc.RTdiff, ExtNoise_Pfc.exgauss_sigma, ExtNoise_Pfc.exgauss_tau},{});

% Epsstr_epspfc

% plotTwoVarTable('mean',{'\epsilon_{str}','\epsilon_{pfc}'},{eps_str_v5,epspfc_v_3},{'MISS','TE','PE','SL'},{Epsstr_epspfc.MISS, Epsstr_epspfc.TE, Epsstr_epspfc.PE, Epsstr_epspfc.SL3},{});
% plotTwoVarTable('mean_minmax',{'\epsilon_{str}','\epsilon_{pfc}'},{eps_str_v5,epspfc_v_3},{'RT_{DR}','RT_{D}','\sigma','\tau'},{Epsstr_epspfc.RTdiff_range, Epsstr_epspfc.RTdiff, Epsstr_epspfc.exgauss_sigma, Epsstr_epspfc.exgauss_tau},{});

% Epspfc_epsstr

% plotTwoVarTable('mean',{'\epsilon_{pfc}','\epsilon_{str}'},{epspfc_v_5,eps_str_v3},{'MISS','TE','PE','SL'},{Epspfc_epsstr.MISS, Epspfc_epsstr.TE, Epspfc_epsstr.PE, Epspfc_epsstr.SL3},{});
% plotTwoVarTable('mean',{'\epsilon_{pfc}','\epsilon_{str}'},{epspfc_v_5,eps_str_v3},{'RT_{DR}','\mu','\sigma','\tau'},{Epspfc_epsstr.RTdiff_range, Epspfc_epsstr.exgauss_mu, Epspfc_epsstr.exgauss_sigma, Epspfc_epsstr.exgauss_tau},{});

% ExtPfc_untimed

% plotTwoVarTable('mean_prop',{'o_{ext}','\epsilon_{pfc}'},{extpfc_v,epspfc_v_3},{'MISS','TE','PE','SL'},{ExtPfc_untimed.MISS, ExtPfc_untimed.TE, ExtPfc_untimed.PE, ExtPfc_untimed.SL3},{});
% plotTwoVarTable('mean_norm',{'o_{ext}','\epsilon_{pfc}'},{extpfc_v,epspfc_v_3},{'RT_{DR}','\mu','\sigma','\tau'},{ExtPfc_untimed.RTdiff_range, ExtPfc_untimed.exgauss_mu, ExtPfc_untimed.exgauss_sigma, ExtPfc_untimed.exgauss_tau},{});

% Epsstr_epspfc_untimed

% plotTwoVarTable('mean',{'\epsilon_{str}','\epsilon_{pfc}'},{eps_str_v5,epspfc_v_3},{'MISS','TE','PE','SL'},{Epsstr_epspfc_untimed.MISS, Epsstr_epspfc_untimed.TE, Epsstr_epspfc_untimed.PE, Epsstr_epspfc_untimed.SL3},{});
% plotTwoVarTable('mean',{'\epsilon_{str}','\epsilon_{pfc}'},{eps_str_v5,epspfc_v_3},{'RT_{DR}','\mu','\sigma','\tau'},{Epsstr_epspfc_untimed.RTdiff_range, Epsstr_epspfc_untimed.exgauss_mu, Epsstr_epspfc_untimed.exgauss_sigma, Epsstr_epspfc_untimed.exgauss_tau},{});

% Epspfc_epsstr_untimed

% plotTwoVarTable('mean',{'\epsilon_{pfc}','\epsilon_{str}'},{eps_pfc_10,eps_str_v3},{'MISS','TE','PE','SL'},{Epspfc_epsstr_untimed.MISS, Epspfc_epsstr_untimed.TE, Epspfc_epsstr_untimed.PE, Epspfc_epsstr_untimed.SL3},{});
% plotTwoVarTable('mean',{'\epsilon_{pfc}','\epsilon_{str}'},{eps_pfc_10,eps_str_v3},{'RT_{DR}','RT_{D}','\sigma','\tau'},{Epspfc_epsstr_untimed.RTdiff_range, Epspfc_epsstr_untimed.RTdiff, Epspfc_epsstr_untimed.exgauss_sigma, Epspfc_epsstr_untimed.exgauss_tau},{});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotTwoVarTable(modality,paramNames,paramList,varNames,varList,refLines)

subPlotDim = [ceil(sqrt(length(varList))),floor(sqrt(length(varList)))]; 
if length(varNames) ~= length(varList)
 error('The list of names and the list of variables must have the same number of elements');
end
if strcmp(modality, 'mean_prop')
 Xprop = input('How many stimuli (cards) each run? ');
end
pl = zeros(1,size(paramList{2},2));
cols = {'sr-','sb-','sg-','sm-','sk-'};
cols_ref = {'k--','r--','b--','m--'};

for nn = 1:length(varNames)  % number of plots
 for cc = 1:size(paramList{2},2) % number of lines in each plot
  subplot(subPlotDim(1),subPlotDim(2),nn);
  hold on;
  switch modality
   case 'mean'
    hold on;
    Xvar = trimmean(varList{nn},10,'round',3);
    XvarSE = std(varList{nn},1,3)/size(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
   case 'mean_prop'
    hold on;
    Xvar = trimmean(varList{nn},10,'round',3)/Xprop;
    XvarSE = std(varList{nn}/Xprop,1,3)/size(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
    ylim([-0.1 1.1]);
    xlim([min(paramList{1}(:)), max(paramList{1}(:))]);
   case 'mean_norm'
    hold on;
    Xmax = max(varList{nn}(:));
    Xvar = trimmean(varList{nn},10,'round',3)/Xmax;
    XvarSE = std(varList{nn}/Xmax,1,3)/size(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
    ylim([-0.1 1.1]);
    xlim([min(paramList{1}(:))*0.9, max(paramList{1}(:))*1.1]);
   case 'mean_minmax'
    hold on;
    Xmax = max(varList{nn}(:));
    Xmin = min(varList{nn}(:));
    Xvar = (trimmean(varList{nn},10,'round',3) - Xmin) / (Xmax - Xmin);
    XvarSE = std((varList{nn}-Xmin)/(Xmax-Xmin),1,3)/size(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
    ylim([-0.1 1.1]);
    xlim([min(paramList{1}(:))*0.9, max(paramList{1}(:))*1.1]);
     
   case 'median'
    Xvar = median(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),'s-');
   case 'mode'
    Xvar = mode(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),'s-');
  end
    legendText{cc} = [paramNames{2},' = ', num2str(paramList{2}(cc))]; 
 end
 
 xlabel(paramNames{1});
 title(varNames{nn});
 legend(pl, legendText);
 %xlim([0 0.5]);
 % plot reference lines
 if ~isempty(refLines)
  ref_line = [min(paramList{1}):0.01:max(paramList{1})];
  for rr = 1:length(refLines{nn})
    plot(ref_line,refLines{nn}(rr)*ones(1,length(ref_line)),cols_ref{rr});
  end
 end
 hold off; 
end


end