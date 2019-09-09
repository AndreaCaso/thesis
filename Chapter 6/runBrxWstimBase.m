%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing the gamma parameter
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxWstimBase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxWstimBase = struct;

% Learning   of choice for the simulation
w_stim_base_v = linspace(0.0,0.7,5); 
epsilon_pfc_v = round(linspace(0.25,0.75,2),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 25; % FROM runBRX_Set
numTrialsx = length(w_stim_base_v)*length(epsilon_pfc_v);

BrxWstimBase.TE = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxWstimBase.PRSRE = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxWstimBase.PRE = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxWstimBase.PRU = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);

BrxWstimBase.P1 = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxWstimBase.P3 = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);

BrxWstimBase.RT = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxWstimBase.RTcorr = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxWstimBase.RTincorr = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);

for w_rule_c = 1:length(w_stim_base_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  w_RULE = w_rule_v(w_rule_c); 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRXvar_Set(totalTrials,'weights.w_RULE_PRES',w_RULE);
  fprintf('completed\n');
   
  BrxWstimBase.TE(w_rule_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxWstimBase.PRSRE(w_rule_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxWstimBase.PRE(w_rule_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxWstimBase.PRU(w_rule_c,pfc_c,:) = [subj_sim_brx.PRU];
  %BrxWstimBase.BRE(str_c,pfc_c,:) = [subj_sim_brx.BRE];
  
  BrxWstimBase.P1(w_rule_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxWstimBase.P3(w_rule_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxWstimBase.RT(w_rule_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxWstimBase.RTcorr(w_rule_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxWstimBase.RTincorr(w_rule_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  runTrialx = runTrialx + 1;
  %save ('BrxWstimBaseVariations.mat','epsilon_str_v','epsilon_pfc_v','BrxWstimBase', '-append');

 end
end
