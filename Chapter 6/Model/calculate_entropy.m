function H_out = calculate_entropy(act)

% normalise it to have total probability equal to 1
act = act + 10e-3;
act_max = ones(1,length(act)) + 10e-3;

pp = act/sum(act); %turn activation into probabilities
pp_max = act_max/sum(act_max); 

% calculate uncertainty through entropy
hh = sum(-pp.*log(pp));  % turn probabilities into an entropy value
hh_max = sum(-pp_max.*log(pp_max));

% forbid NaN values 
if any(isnan(hh))
 hh = 0;
end

% normalise output vector (max will be 1)
H_out = hh/hh_max;

end