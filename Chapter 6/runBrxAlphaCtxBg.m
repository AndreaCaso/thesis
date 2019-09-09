%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing the gamma parameter
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxAlphaCtxBg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxAlphaCtxBg = struct;

% Learning of choice for the simulation
w_stim_base_v = linspace(0.0,0.7,5); 
epsilon_pfc_v = round(linspace(0.25,0.75,2),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 25; % FROM runBRX_Set
numTrialsx = length(w_stim_base_v)*length(epsilon_pfc_v);

BrxAlphaCtxBg.TE = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaCtxBg.PRSRE = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaCtxBg.PRE = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaCtxBg.PRU = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);

BrxAlphaCtxBg.P1 = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaCtxBg.P3 = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);

BrxAlphaCtxBg.RT = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaCtxBg.RTcorr = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaCtxBg.RTincorr = nan(length(w_stim_base_v),length(epsilon_pfc_v),totalTrials);

for w_stim_base_c = 1:length(w_stim_base_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  w_STIM_BASE = w_stim_base_v(w_stim_base_c); 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRXvar_Set(totalTrials,'weights.w_STIM_BASE',w_STIM_BASE);
  fprintf('completed\n');
   
  BrxAlphaCtxBg.TE(w_stim_base_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxAlphaCtxBg.PRSRE(w_stim_base_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxAlphaCtxBg.PRE(w_stim_base_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxAlphaCtxBg.PRU(w_stim_base_c,pfc_c,:) = [subj_sim_brx.PRU];
  %BrxAlphaCtxBg.BRE(str_c,pfc_c,:) = [subj_sim_brx.BRE];
  
  BrxAlphaCtxBg.P1(w_stim_base_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxAlphaCtxBg.P3(w_stim_base_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxAlphaCtxBg.RT(w_stim_base_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxAlphaCtxBg.RTcorr(w_stim_base_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxAlphaCtxBg.RTincorr(w_stim_base_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  runTrialx = runTrialx + 1;
  %save ('BrxAlphaCtxBgVariations.mat','epsilon_str_v','epsilon_pfc_v','BrxAlphaCtxBg', '-append');

 end
end
