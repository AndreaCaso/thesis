%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing the gamma parameter
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxWrule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxWrule = struct;

% Learning   of choice for the simulation
w_rule_v = linspace(0.1,1.4,10); 
epsilon_pfc_v = round(linspace(0.25,0.75,2),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 25; % FROM runBRX_Set
numTrialsx = length(w_rule_v)*length(epsilon_pfc_v);

BrxWrule.TE = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);
BrxWrule.PRSRE = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);
BrxWrule.PRE = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);
BrxWrule.PRU = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);

BrxWrule.P1 = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);
BrxWrule.P3 = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);

BrxWrule.RT = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);
BrxWrule.RTcorr = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);
BrxWrule.RTincorr = nan(length(w_rule_v),length(epsilon_pfc_v),totalTrials);

for w_stim_base_c = 1:length(w_rule_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  w_STIM_BASE = w_rule_v(w_stim_base_c); 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRXvar_Set(totalTrials,'weights.w_RULE_PRES',w_STIM_BASE);
  fprintf('completed\n');
   
  BrxWrule.TE(w_stim_base_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxWrule.PRSRE(w_stim_base_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxWrule.PRE(w_stim_base_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxWrule.PRU(w_stim_base_c,pfc_c,:) = [subj_sim_brx.PRU];
  %BrxWrule.BRE(str_c,pfc_c,:) = [subj_sim_brx.BRE];
  
  BrxWrule.P1(w_stim_base_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxWrule.P3(w_stim_base_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxWrule.RT(w_stim_base_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxWrule.RTcorr(w_stim_base_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxWrule.RTincorr(w_stim_base_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  runTrialx = runTrialx + 1;
  
 end
end
