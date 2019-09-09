function H_out = calculate_entropy(act)
 
% normalise it to have total probability equal to 1
act = act + 1e-3;
act_max = ones(1,length(act)) + 1e-3;
%act_min = zeros(1,length(act)) + 1e-10; act_min(1) = 1;

pp = act/sum(act); %turn activation into probabilities
pp_max = act_max/sum(act_max); 
%pp_min = act_min/sum(act_min);

% calculate uncertainty through entropy
hh = sum(-pp.*log(pp));  % turn probabilities into an entropy value
hh_max = sum(-pp_max.*log(pp_max));
%hh_min = sum(-pp_min.*log(pp_min));

% forbid NaN values 
if any(isnan(hh))
 hh = 0;
end

% normalise output vector (max will be 1)
H_out = (hh)/(hh_max);

end