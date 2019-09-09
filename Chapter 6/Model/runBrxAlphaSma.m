%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing the weights.w_STIM_PRES parameter
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxGamma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxAlphaSma = struct;

% Learning   of choice for the simulation
alpha_sma_v = linspace(6,12,11); 
epsilon_pfc_v = round(linspace(0.05,0.85,3),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 10; % FROM runBRX_Set
numTrialsx = length(alpha_sma_v)*length(epsilon_pfc_v);

BrxAlphaSma.TE = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.PRSRE = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.PRE = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.PRU = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);

BrxAlphaSma.P1 = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.P3 = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);

BrxAlphaSma.RT = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.RTcorr = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.RTincorr = nan(length(alpha_sma_v),length(epsilon_pfc_v),totalTrials);

for ext_c = 1:length(alpha_sma_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  alpha_sma = alpha_sma_v(ext_c); 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRX_Set(totalTrials,0.5,epsilon_pfc, 0, 1, alpha_sma, 0.45);
  fprintf('completed\n');
   
  BrxAlphaSma.TE(ext_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxAlphaSma.PRSRE(ext_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxAlphaSma.PRE(ext_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxAlphaSma.PRU(ext_c,pfc_c,:) = [subj_sim_brx.PRU];
  
  BrxAlphaSma.P1(ext_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxAlphaSma.P3(ext_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxAlphaSma.RT(ext_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxAlphaSma.RTcorr(ext_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxAlphaSma.RTincorr(ext_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  BrxAlphaSma.trials(ext_c,pfc_c,:) = [subj_sim_brx.trials];
  
  runTrialx = runTrialx + 1;
  %save ('BrxGammaVariations.mat','epsilon_str_v','epsilon_pfc_v','BrxGamma', '-append');

 end
end
