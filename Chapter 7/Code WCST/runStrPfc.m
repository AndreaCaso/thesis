%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the WSCT changing three parameters
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called StrPfc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
StrPfc = struct;
epsilon_str_v = linspace(0,1,7); % learning rate for striatum 
epsilon_pfc_v = linspace(0,1,3); % learning rate for pfc 

runTrialx = 1; %Total counter
totalTrials = 20; % FROM runWCST_Set
numTrialsx = length(epsilon_str_v)*length(epsilon_pfc_v);

StrPfc.TE = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
StrPfc.CC = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
StrPfc.LTL = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
   
StrPfc.PR = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
StrPfc.PE = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
StrPfc.SL = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
StrPfc.SL3 = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
StrPfc.NPE = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
  
StrPfc.RT = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
StrPfc.RTcorr = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);
StrPfc.RTincorr = nan(length(epsilon_str_v),length(epsilon_pfc_v),totalTrials);

for str_c = 1:length(epsilon_str_v)
 for pfc_c = 1:length(epsilon_pfc_v)
  
  epsilon_str = epsilon_str_v(str_c); % learning rate for striatum 
  epsilon_pfc = epsilon_pfc_v(pfc_c); % learning rate for pfc 
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_wcst = runWCST_Set(totalTrials,epsilon_str,epsilon_pfc);   
  fprintf('completed\n');
  
  StrPfc.TE(str_c,pfc_c,:) = subj_sim_wcst.TE;
  StrPfc.CC(str_c,pfc_c,:) = subj_sim_wcst.CC;
  StrPfc.LTL(str_c,pfc_c,:) = subj_sim_wcst.LTL;
   
  StrPfc.PE(str_c,pfc_c,:) = subj_sim_wcst.PE;
  StrPfc.SL3(str_c,pfc_c,:) = subj_sim_wcst.SL3;
  StrPfc.NPE(str_c,pfc_c,:) = subj_sim_wcst.NPE;
  
  StrPfc.RT(str_c,pfc_c,:) = [subj_sim_wcst.RTall];
  StrPfc.RTcorr(str_c,pfc_c,:) = [subj_sim_wcst.RTcorr];
  StrPfc.RTcorr(str_c,pfc_c,:) = [subj_sim_wcst.RTincorr];
  
  runTrialx = runTrialx + 1;
 
 end
end

%plotStrPfc([2,2],'mean',{epsilon_str_v,epsilon_pfc_v},{'TE','PE','SL','NPE'},{StrPfc.TE,StrPfc.PE,StrPfc.SL,StrPfc.NPE});

