%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing the weights.w_STIM_PRES parameter
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxGamma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxWeightStimPres = struct;

% Learning   of choice for the simulation
w_STIM_PRES_v = linspace(0.00,0.50,11); 
epsilon_pfc_v = round(linspace(0.05,0.85,3),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 10; % FROM runBRX_Set
numTrialsx = length(w_STIM_PRES_v)*length(epsilon_pfc_v);

BrxWeightStimPres.TE = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);
BrxWeightStimPres.PRSRE = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);
BrxWeightStimPres.PRE = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);
BrxWeightStimPres.PRU = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);

BrxWeightStimPres.P1 = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);
BrxWeightStimPres.P3 = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);

BrxWeightStimPres.RT = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);
BrxWeightStimPres.RTcorr = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);
BrxWeightStimPres.RTincorr = nan(length(w_STIM_PRES_v),length(epsilon_pfc_v),totalTrials);

for ext_c = 1:length(w_STIM_PRES_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  w_STIM_PRES = w_STIM_PRES_v(ext_c); 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRX_Set(totalTrials,0.5,epsilon_pfc, 0, 1, 10, 0.45);
  fprintf('completed\n');   
  
  BrxWeightStimPres.TE(ext_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxWeightStimPres.PRSRE(ext_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxWeightStimPres.PRE(ext_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxWeightStimPres.PRU(ext_c,pfc_c,:) = [subj_sim_brx.PRU];
  
  BrxWeightStimPres.P1(ext_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxWeightStimPres.P3(ext_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxWeightStimPres.RT(ext_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxWeightStimPres.RTcorr(ext_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxWeightStimPres.RTincorr(ext_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  BrxWeightStimPres.trials(ext_c,pfc_c,:) = [subj_sim_brx.trials];
  
  runTrialx = runTrialx + 1;
  %save ('BrxGammaVariations.mat','epsilon_str_v','epsilon_pfc_v','BrxGamma', '-append');

 end
end
