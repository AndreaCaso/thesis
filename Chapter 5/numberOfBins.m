function n_bins = numberOfBins(data,edges)
 n_bins = 5;
 while true
  values = histcounts(data,edges);
  if ~any(values==0) || n_bins <= 2
   break;    
  end
  n_bins = n_bins - 1;
 end
end