% The script takes a performance.RT vector 
% and randomly samples 

function performancesRT_smooth = plotBoost(performancesRT)
 performancesRT_smooth = performancesRT;
 
 for n = 1:(1000)
     
  sampled_idx = randi([1 length(performancesRT_smooth)-1]);
  new_value = mean([performancesRT_smooth(sampled_idx) performancesRT_smooth(sampled_idx+1)]);
  performancesRT_smooth = [performancesRT_smooth, new_value];
  
 end
end