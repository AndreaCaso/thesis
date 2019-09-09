%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function boostrap the values for all the variables in the argument
% and produces correlation plots
% Usage example:
% bootstrapAndPlot(1000,{'TE','PE','SL'},YoungNPdata(:,[1 3 4]),YoungSIMdata(:,[1 3 4]))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bootstrapAndPlot(bstrpFactor,name_list,varargin)

rng default  % For reproducibility;
bstrpSets = cell(1,nargin-2);

for cc = 1:nargin-2
    bstrpSets{cc} = bootstrp(bstrpFactor,@mean,varargin{cc});
    corrplot(bstrpSets{cc},'type','Spearman','testR','on','alpha',1/bstrpFactor, 'varNames', name_list);
    set(gcf,'Name', ['Set ', num2str(cc)]);
end

end