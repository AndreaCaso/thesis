%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function show in 3D how variables in the input matrix data
% are cluster. Usage example:
% plot3Dclusters({'TE','PE','SL'},YoungNPdataSET,YoungSIMdataSET)
% types for plot3Dclusters(cell,cell,cell)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot3Dclusters(name_list,varargin)

for figs = 1:nargin-1
figure; 
hold on;
idxNP = size(varargin{figs},2);

for cc = 1:max(idxNP)
SetToPlot = varargin{figs};
sc3 = scatter3(SetToPlot{cc}(:,1),SetToPlot{cc}(:,2),SetToPlot{cc}(:,3),30,'filled');
hh = get(sc3, 'CData');
%sc3c = scatter3(centrNP(cc,1),centrNP(cc,2 ),centrNP(cc,3),120,'d','filled');
%set(sc3c, 'CData', hh);
%set(sc3c, 'MarkerEdgeColor', 'k');

end

xlabel(name_list{1});
ylabel(name_list{2});
zlabel(name_list{3});

grid('on');

clear sc3, clear sc3c, clear hh;

fprintf('\nSet %s\n',num2str(figs));

%% Print groups data 
for g_num = 1:length(SetToPlot)
  
    fprintf('Group %1.0f\nMean: %s \n',g_num, num2str( round(mean(SetToPlot{g_num}),2) ) )
    fprintf('Elements: %1.0f\n',length(SetToPlot{g_num}))
    fprintf('StD %s \n', num2str( round(std(SetToPlot{g_num}),2) ))
    fprintf('Median %s \n', num2str( round(median(SetToPlot{g_num}),2) ))
    fprintf('\n');
    
end

end
