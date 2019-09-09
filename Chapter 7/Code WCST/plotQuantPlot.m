function data = plotQuantPlot(WCST_indivStats)

part_num = length(WCST_indivStats);
trial_num = length([WCST_indivStats.CORR]);

data = []; nn = 1;

for part = 1:part_num
 for trial = 1:trial_num
    
    data(nn,1) = double(WCST_indivStats(part).RTs(trial)); 
    data(nn,2) = double(WCST_indivStats(part).CORR(trial));
 
    data(nn,3) = mod(nn,1);
    data(nn,4) = double(part);
    
    nn = nn + 1;
    
 end
end

quantProbPlot(data, 'scatterPlot',1);
%quantProbPlot(data);
%quantProbPlot(data,'separate',2,'reverse',1)   

end
