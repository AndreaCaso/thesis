%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing the gamma parameter
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxGamma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxGamma = struct;

% Learning   of choice for the simulation
gamma_v = linspace(0,1,5); 
epsilon_pfc_v = round(linspace(0.25,0.75,2),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 25; % FROM runBRX_Set
numTrialsx = length(gamma_v)*length(epsilon_pfc_v);

BrxGamma.TE = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);
BrxGamma.PRSRE = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);
BrxGamma.PRE = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);
BrxGamma.PRU = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);

BrxGamma.P1 = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);
BrxGamma.P3 = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);

BrxGamma.RT = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);
BrxGamma.RTcorr = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);
BrxGamma.RTincorr = nan(length(gamma_v),length(epsilon_pfc_v),totalTrials);

for gamma_c = 1:length(gamma_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  discount_TDV = gamma_v(gamma_c); 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRX_Set(totalTrials,0.5,epsilon_pfc, discount_TDV);
  fprintf('completed\n');
   
  BrxGamma.TE(gamma_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxGamma.PRSRE(gamma_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxGamma.PRE(gamma_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxGamma.PRU(gamma_c,pfc_c,:) = [subj_sim_brx.PRU];
  %BrxGamma.BRE(str_c,pfc_c,:) = [subj_sim_brx.BRE];
  
  BrxGamma.P1(gamma_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxGamma.P3(gamma_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxGamma.RT(gamma_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxGamma.RTcorr(gamma_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxGamma.RTincorr(gamma_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  runTrialx = runTrialx + 1;
  %save ('BrxGammaVariations.mat','epsilon_str_v','epsilon_pfc_v','BrxGamma', '-append');

 end
end
