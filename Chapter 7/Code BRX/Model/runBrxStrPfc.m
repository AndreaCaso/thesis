%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the BRX changing three parameters
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called BrxBrxStrPfc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxStrPfc = struct;

% Learning   of choice for the simulation
epsilon_str_v = linspace(0,1,11); 
epsilon_pfc_v = round(linspace(0,1,4),2);

runTrialx = 1; %Total counter initialisation
totalTrials = 25; % FROM runBRX_Set
numTrialsx = length(epsilon_str_v)*length(epsilon_pfc_v);

BrxStrPfc.TE = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
BrxStrPfc.PRSRE = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
BrxStrPfc.PRE = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
BrxStrPfc.PRU = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);

BrxStrPfc.P1 = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
BrxStrPfc.P3 = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);

BrxStrPfc.RT = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
BrxStrPfc.RTcorr = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
BrxStrPfc.RTincorr = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);

for str_c = 1:length(epsilon_str_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  epsilon_str = epsilon_str_v(str_c); % learning rate for striatum 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRX_Set(totalTrials,epsilon_str,epsilon_pfc);
  fprintf('completed\n');
   
  BrxStrPfc.TE(str_c,pfc_c,:) = [subj_sim_brx.TE];
  BrxStrPfc.PRSRE(str_c,pfc_c,:) = [subj_sim_brx.PRSRE];
  BrxStrPfc.PRE(str_c,pfc_c,:) = [subj_sim_brx.PRE];
  BrxStrPfc.PRU(str_c,pfc_c,:) = [subj_sim_brx.PRU];
  %BrxStrPfc.BRE(str_c,pfc_c,:) = [subj_sim_brx.BRE];
  
  BrxStrPfc.P1(str_c,pfc_c,:) = [subj_sim_brx.P1];
  BrxStrPfc.P3(str_c,pfc_c,:) = [subj_sim_brx.P3];
  
  BrxStrPfc.RT(str_c,pfc_c,:) = [subj_sim_brx.RT];
  BrxStrPfc.RTcorr(str_c,pfc_c,:) = [subj_sim_brx.RTcorr];
  BrxStrPfc.RTincorr(str_c,pfc_c,:) = [subj_sim_brx.RTincorr];
  
  runTrialx = runTrialx + 1;
  %save ('BrxStrPfcVariations.mat','epsilon_str_v','epsilon_pfc_v','BrxStrPfc', '-append');

 end
end
