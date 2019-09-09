%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing the gamma parameter
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxGamma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxAlphaSma = struct;

% Learning   of choice for the simulation
alphasma_v = linspace(5,12,5); 
epsilon_pfc_v = round(linspace(0.20,0.70,3),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 25; % FROM runBRX_Set
numTrialsx = length(alphasma_v)*length(epsilon_pfc_v);

BrxAlphaSma.TE = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.PRSRE = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.PRE = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.PRU = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);

BrxAlphaSma.P1 = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.P3 = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);

BrxAlphaSma.RT = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.RTcorr = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);
BrxAlphaSma.RTincorr = nan(length(alphasma_v),length(epsilon_pfc_v),totalTrials);

for alphasma_c = 1:length(alphasma_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  alphasma = alphasma_v(alphasma_c); 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRX_Set(totalTrials,0.5,epsilon_pfc, 1, alphasma);
  fprintf('completed\n');
   
  BrxAlphaSma.TE(alphasma_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxAlphaSma.PRSRE(alphasma_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxAlphaSma.PRE(alphasma_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxAlphaSma.PRU(alphasma_c,pfc_c,:) = [subj_sim_brx.PRU];
  %BrxGamma.BRE(str_c,pfc_c,:) = [subj_sim_brx.BRE];
  
  BrxAlphaSma.P1(alphasma_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxAlphaSma.P3(alphasma_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxAlphaSma.RT(alphasma_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxAlphaSma.RTcorr(alphasma_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxAlphaSma.RTincorr(alphasma_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  runTrialx = runTrialx + 1;
  %save ('BrxGammaVariations.mat','epsilon_str_v','epsilon_pfc_v','BrxGamma', '-append');

 end
end
