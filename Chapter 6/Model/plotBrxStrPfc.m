%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Usage example:
% plotBrxStrPfc('mean',{epsilon_str_v,epsilon_pfc_v},{'TE','PRSRE','PRE','PRU'},{BrxStrPfc.TE,BrxStrPfc.PRSRE,BrxStrPfc.PRE,BrxStrPfc.PRU},{12.8600,1.4800,1.28,3.92}, 'w_{rule}');
% plotBrxStrPfc('mean',{linspace(0.1,0.9,7), linspace(0.1,0.5,5)},{'TE','PRSRE','PRE','PRU'},{BrxWruleWstim.TE,BrxWruleWstim.PRSRE,BrxWruleWstim.PRE,BrxWruleWstim.PRU},{}, {'w_{rule}', 'w_{stim,base}' });
% plotBrxStrPfc('mean',{linspace(-1,+1,10), linspace(0.10,0.50,3)},{'TE','PRSRE','PRE','PRU'},{BrxReward.TE,BrxReward.PRSRE,BrxReward.PRE,BrxReward.PRU},{}, {'r_{add}', '\epsilon_{pfc}' });
% 
% for RTs
%
% plotBrxStrPfc('mean',{epsilon_str_v,epsilon_pfc_v},{'RT','RT in PRSRE','RT in SL5','RT in SL3'},{BrxStrPfc.RT,BrxStrPfc.RTpeS,BrxStrPfc.RTsl5S,BrxStrPfc.RTsl3S});
% plotBrxStrPfc('mean',{epsilon_str_v,mean(epsilon_pfc_v)},{'TE','PRSRE','SL3','RT'},{mean(BrxStrPfc.TE,2),mean(BrxStrPfc.PRSRE,2),mean(BrxStrPfc.SL3,2),mean(BrxStrPfc.RT,2)});
% plotBrxStrPfc('mean',{linspace(-1,+1,10), linspace(0.10,0.50,3)},{'Trials','RT','RTcorr','RTincorr'},{BrxReward.trials,BrxReward.RT,BrxReward.RTcorr,BrxReward.RTincorr},{}, {'r_{add}', '\epsilon_{pfc}' });

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotBrxStrPfc(modality,paramList,varNames,varList,refLines, x_label)

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
  case 'max'
    hold on;
    %Xsize = size(varList{nn}(~isnan(varList{nn})),3); %wrong!
    Xvar = max(varList{nn},[],3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
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
   legendText{cc} = [x_label{2}, ' = ', num2str(paramList{2}(cc))]; 
 % plot reference lines
  if ~isempty(refLines)
     for ref_per_plot = 1:length(refLines{nn})
        rl = refline([0 refLines{nn}(ref_per_plot)]);
        set(rl, 'LineStyle', '--');
     end
  end
 end
 
 xlabel(x_label{1});
 
 title(varNames{nn});
 legend(pl, legendText);
 %xlim([0 0.5]);
 hold off; 
end
end