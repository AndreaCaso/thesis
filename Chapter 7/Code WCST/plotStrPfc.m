%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Usage example:
% plotStrPfc('mean',{'\epsilon_{str}','\epsilon_{pfc}'},{epsilon_str_v,epsilon_pfc_v},{'TE','PE','SL','NPE'},{StrPfc.TE,StrPfc.PE,StrPfc.SL,StrPfc.NPE},{[14.79, 18.54, 23.86], [9.40, 9.66, 17.89], [0.21, 0.46, 0.57], [5.40, 8.89, 8.77]});
% plotStrPfc('mean',{'\epsilon_{pfc}','\epsilon_{str}'},{epsilon_pfc_v2,epsilon_str_v2},{'TE','PE','SL','NPE'},{StrPfc2.TE,StrPfc2.PE,StrPfc2.SL,StrPfc2.NPE},{[14.79, 18.54, 23.86], [9.40, 9.66, 17.89], [0.21, 0.46, 0.57], [5.40, 8.89, 8.77]});
% plotStrPfc('mean',{'\alpha_{pfc}','\epsilon_{str}'},{alpha_pfc_v,epsilon_str_v3},{'TE','PE','SL','NPE'},{StrPfc3.TE,StrPfc3.PE,StrPfc3.SL,StrPfc3.NPE},{[14.79, 18.54, 23.86], [9.40, 9.66, 17.89], [0.21, 0.46, 0.57], [5.40, 8.89, 8.77]});
% plotStrPfc('mean',{'\gamma','\epsilon_{str}'},{discount_TDV_v,epsilon_str_v4},{'TE','PE','SL','NPE'},{StrPfc4.TE,StrPfc4.PE,StrPfc4.SL,StrPfc4.NPE},{[14.79, 18.54, 23.86], [9.40, 9.66, 17.89], [0.21, 0.46, 0.57], [5.40, 8.89, 8.77]});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotStrPfc(modality,paramNames,paramList,varNames,varList,refLines)

subPlotDim = [ceil(sqrt(length(varList))),floor(sqrt(length(varList)))]; 
if length(varNames) ~= length(varList)
 error('The list of names and the list of variables must have the same number of elements');
end
pl = zeros(1,size(paramList{2},2));
cols = {'sr-','sb-','sg-','sm-','sk-'};
cols_ref = {'k--','r--','b--','m--'};

for nn = 1:length(varNames);    % number of plots
 for cc = 1:size(paramList{2},2) % number of lines in each plot
  subplot(subPlotDim(1),subPlotDim(2),nn);
  hold on;
  switch modality
   case 'mean'
    hold on;
    Xvar = nanmean(varList{nn},3);
    XvarSE = std(varList{nn},1,3)/size(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
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