% This script generates the RT curves for varying parameters and
% it saves results into a structure

% exgauss_str = genExGaussFitVsXvar('epsilon.eps_str', 0.0:0.05:0.7, 25);
% exgauss_ctx = genExGaussFitVsXvar('epsilon.eps_pfc', 0.0:0.05:0.7, 25);

function exgauss = genExGaussFitVsXvar(x_var, x_range, part_num)
        
exgauss = struct();
exgauss.x_var = x_var;
exgauss.x_range = x_range;

for x_idx = 1:length(x_range)
 for trial_num = 1:part_num
    
  initialiseWCST;
  eval([x_var, ' = ', num2str(x_range(x_idx)),';']);
  runWCST;

  [fit_vector,~,~] = exgauss_fit(performances.RT);

  exgauss.mu_sigma_tau(x_idx, :, trial_num) = fit_vector;

 end
end
end