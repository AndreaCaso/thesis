%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing the extPFC parameter
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxGamma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxExt = struct;

% Learning   of choice for the simulation
ext_v = linspace(0.80,1,5); 
epsilon_pfc_v = round(linspace(0.25,0.75,2),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 10; % FROM runBRX_Set
numTrialsx = length(ext_v)*length(epsilon_pfc_v);

BrxExt.TE = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);
BrxExt.PRSRE = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);
BrxExt.PRE = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);
BrxExt.PRU = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);

BrxExt.P1 = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);
BrxExt.P3 = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);

BrxExt.RT = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);
BrxExt.RTcorr = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);
BrxExt.RTincorr = nan(length(ext_v),length(epsilon_pfc_v),totalTrials);

for ext_c = 1:length(ext_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  extPFC = ext_v(ext_c); 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRX_Set(totalTrials,0.5,epsilon_pfc, 0, extPFC);
  fprintf('completed\n');
   
  BrxExt.TE(ext_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxExt.PRSRE(ext_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxExt.PRE(ext_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxExt.PRU(ext_c,pfc_c,:) = [subj_sim_brx.PRU];
  %BrxGamma.BRE(str_c,pfc_c,:) = [subj_sim_brx.BRE];
  
  BrxExt.P1(ext_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxExt.P3(ext_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxExt.RT(ext_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxExt.RTcorr(ext_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxExt.RTincorr(ext_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  runTrialx = runTrialx + 1;
  %save ('BrxGammaVariations.mat','epsilon_str_v','epsilon_pfc_v','BrxGamma', '-append');

 end
end
