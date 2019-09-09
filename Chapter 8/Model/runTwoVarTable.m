%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the WSCT changing three parameters
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called TwoVarTableT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
TwoVarTable = struct;

out_var = input('Output variable name: ', 's');

% Name of the manipulated variables

first_var_str = input('First var name: ', 's');
second_var_str = input('Second var name: ', 's');

% Range
range_first_var(1) = input('Left boundary - First var: '); 
range_first_var(2) = input('Right boundary - First var: ');
division_var(1) = input('Number of trials across space - First var: ');

range_second_var(1) = input('Left boundary - Second var: '); 
range_second_var(2) = input('Right boundary - Second var: ');
division_var(2) = input('Number of trials across space - Second var: ');

first_var_v = linspace(range_first_var(1),range_first_var(2),division_var(1)); %e4 or e5 ? 
second_var_v = linspace(range_second_var(1),range_second_var(2),division_var(2)); 

% Total trials
totalTrials = input('Total number of trials: '); 
timedYN = input('Timed (T) or Untimed (U): ','s');

fprintf('Beginning time: %s\n', datestr(now,'HH:MM'));

runTrialx = 1;
numTrialsx = length(first_var_v)*length(second_var_v);

TwoVarTable.TE = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.CC = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.MISS = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.LL = nan(length(first_var_v),length(second_var_v),totalTrials);

TwoVarTable.PE = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.SL3 = nan(length(first_var_v),length(second_var_v),totalTrials);
 
TwoVarTable.RT = nan(length(first_var_v),length(second_var_v),totalTrials);

TwoVarTable.exgauss_mu = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.exgauss_sigma = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.exgauss_tau = nan(length(first_var_v),length(second_var_v),totalTrials);

% Calculate the baseline distribution that will serve 
% to calculate the RTdiff 
fprintf('Running a trial without MISS threshold\n');
timed = false; 
initialiseWCST;
runWCST;
RT_U = performances.RT;
fprintf('completed\n');

timed = strcmpi(timedYN,'t'); % reset the threshold

for first_var_c = 1:length(first_var_v)
 for second_var_c = 1:length(second_var_v)
  
  timed = strcmpi(timedYN,'t');
 
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_wcst = runWCSTvar_Set(totalTrials,timed,{first_var_str,second_var_str},{first_var_v(first_var_c),second_var_v(second_var_c)});   
  fprintf('completed\n');
  
  TwoVarTable.TE(first_var_c,second_var_c,:) = [subj_sim_wcst.TE];
  TwoVarTable.CC(first_var_c,second_var_c,:) = [subj_sim_wcst.CC];
  TwoVarTable.MISS(first_var_c,second_var_c,:) = [subj_sim_wcst.MISS];
  
  TwoVarTable.PE(first_var_c,second_var_c,:) = [subj_sim_wcst.PE];
  TwoVarTable.SL3(first_var_c,second_var_c,:) = [subj_sim_wcst.SL3];
  
  % Calculate RT_diff and RT_diff_range 
  RT_T = [];
  for part = 1:size(subj_sim_wcst,2)
   
   RT(part) = nanmedian([subj_sim_wcst(part).RT]);
   RT_T(part, :) = [subj_sim_wcst(part).RT];
   
   RT_diff(part) = nanmedian(RT_U) - nanmedian(RT_T(part, :));
   RT_diff_bts(part,:) = bootstrp(10000,@(x,y) nanmedian(x) - nanmedian(y),RT_U,RT_T(part,:));
   RT_diff_range(part) = quantile(RT_diff_bts(part,:),0.95) - quantile(RT_diff_bts(part,:),0.05);
  
  end
  
  TwoVarTable.RT(first_var_c,second_var_c,:) = RT;
  TwoVarTable.RTdiff(first_var_c,second_var_c,:) = RT_diff;
  TwoVarTable.RTdiff_range(first_var_c,second_var_c,:) = RT_diff_range;
  
  for part = 1:size(subj_sim_wcst,2)
   % And mu, sigma, tau for the RT distribution
   [fit_vector,LL,~] = exgauss_fit([subj_sim_wcst(part).RT]);
   
   mu_var(part) = fit_vector(1);
   sigma_var(part) = fit_vector(2);
   tau_var(part) = fit_vector(3);
   negLL(part) = -LL;
   
  end
  TwoVarTable.exgauss_mu(first_var_c,second_var_c,:) = mu_var;
  TwoVarTable.exgauss_sigma(first_var_c,second_var_c,:) = sigma_var;
  TwoVarTable.exgauss_tau(first_var_c,second_var_c,:) = tau_var;
  TwoVarTable.LL(first_var_c,second_var_c,:) = negLL; %log-likelihood
  
  runTrialx = runTrialx + 1;
 
 end
end

eval([out_var,' = TwoVarTable;']);
eval(['save TwoVarTables.mat ', out_var, ' -append']);
fprintf('\nEnding time: %s\n', datestr(now,'HH:MM'))

