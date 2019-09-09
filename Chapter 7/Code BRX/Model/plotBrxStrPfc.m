%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Usage example:
% plotBrxStrPfc('mean',{epsilon_str_v,epsilon_pfc_v},{'TE','PRSRE','PRE','PRU'},{BrxStrPfc.TE,BrxStrPfc.PRSRE,BrxStrPfc.PRE,BrxStrPfc.PRU},{12.8600,1.4800,1.28,3.92});
% plotBrxStrPfc('mean',{epsilon_str_v,epsilon_pfc_v},{'P1','P3'},{BrxStrPfc.P1,BrxStrPfc.P3},{[4.2916, 7.4200,10.5484], [2.5225,5.4400,8.3575]});
% plotBrxStrPfc('mean',{epsilon_str_v,epsilon_pfc_v},{'TE','PRSRE','PRE','RT'},{BrxStrPfc.TE,BrxStrPfc.PRSRE,BrxStrPfc.PRE,BrxStrPfc.RT})
% for RTs
% plotBrxStrPfc('mean',{epsilon_str_v,epsilon_pfc_v},{'RT','RT in PRSRE','RT in SL5','RT in SL3'},{BrxStrPfc.RT,BrxStrPfc.RTpeS,BrxStrPfc.RTsl5S,BrxStrPfc.RTsl3S});
% across all epsilon_pfc values
% plotBrxStrPfc('mean',{epsilon_str_v,mean(epsilon_pfc_v)},{'TE','PRSRE','SL3','RT'},{mean(BrxStrPfc.TE,2),mean(BrxStrPfc.PRSRE,2),mean(BrxStrPfc.SL3,2),mean(BrxStrPfc.RT,2)});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotBrxStrPfc(modality,paramList,varNames,varList,refLines)

subPlotDim = numSubplots(length(varList));
if length(varNames) ~= length(varList)
 error('The list of names and the list of variables must have the same number of elements');
end
pl = zeros(1,size(paramList{2},2));
cols = {'sr-','sb-','sg-','sm-','sk-'};
cols_ref = {'k--','r--','b--','m--'};

for nn = 1:length(varNames)   % number of plots
 for cc = 1:size(paramList{2},2) % number of lines in each plot
  subplot(subPlotDim(1),subPlotDim(2),nn);
  hold on;
  switch modality
   case 'mean'
       hold on;
    %Xsize = size(varList{nn}(~isnan(varList{nn})),3); %wrong!
    Xsize = size(varList{nn},3);
    Xvar = nanmean(varList{nn},3);
    XvarSE = nanstd(varList{nn},1,3)/(Xsize);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
   case 'median'
    Xvar = median(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),'s-');
   case 'mode'
    Xvar = mode(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),'s-');
   case 'std'
    Xvar = nanstd(varList{nn},1,3);  
    pl(cc) = plot(paramList{1}, Xvar(:,cc),'s-');
  end
   legendText{cc} = ['\epsilon_{pfc} = ', num2str(paramList{2}(cc))]; 
 % plot reference lines
  if ~isempty(refLines)
     for ref_per_plot = 1:length(refLines{nn})
        rl = refline([0 refLines{nn}(ref_per_plot)]);
        set(rl, 'LineStyle', '--');
     end
  end
 end
 
 xlabel('\epsilon_{str}');
 title(varNames{nn});
 legend(pl, legendText);
 %xlim([0 0.5]);
 hold off; 
end
end