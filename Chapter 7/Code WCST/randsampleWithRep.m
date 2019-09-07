function sample = randsampleWithRep(data,k)
 len = length(data);
 if isempty(k)
  k = length(data); 
 end
 for c = 1:k  
  idx = randi([1 len]);
  sample(c) = data(idx);
 end
end