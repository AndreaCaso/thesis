function c = into_chunks(array, dim)

c = cell(1, ceil(numel(array))-1);
for i = 0:length(c)-1
    c{i+1} = array( (1+i) : min(numel(array), (i+dim)) );
end

end