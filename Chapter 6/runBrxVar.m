% usage:
% BrxWruleWstim = runBrxVar(linspace(0.1,0.9,7), linspace(0.1,0.5,5),{'weights.w_RULE_PRES','weights.w_STIM_PRES'});
% BrxReward = runBrxVar(linspace(-1,+1,10),linspace(0.10,0.50,3),{'reward.reward_mod','epsilon.eps_pfc'});

function BrxVar = runBrxVar(var1_v, var2_v, var_strings)

BBrxVar = struct();

fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))
BrxVar = struct;

runTrialx = 1; %Total counter initialisation
totalTrials = 20; % FROM runBRX_Set
numTrialsx = length(var1_v)*length(var2_v);

BrxVar.TE = nan(length(var1_v),length(var2_v),totalTrials);
BrxVar.PRSRE = nan(length(var1_v),length(var2_v),totalTrials);
BrxVar.PRE = nan(length(var1_v),length(var2_v),totalTrials);
BrxVar.PRU = nan(length(var1_v),length(var2_v),totalTrials);

BrxVar.P1 = nan(length(var1_v),length(var2_v),totalTrials);
BrxVar.P3 = nan(length(var1_v),length(var2_v),totalTrials);

BrxVar.RT = nan(length(var1_v),length(var2_v),totalTrials);
BrxVar.RTcorr = nan(length(var1_v),length(var2_v),totalTrials);
BrxVar.RTincorr = nan(length(var1_v),length(var2_v),totalTrials);
BrxVar.trials = nan(length(var1_v),length(var2_v),totalTrials);

for var1_c = 1:length(var1_v)
 for var2_c = 1:length(var2_v)
  
  var_val{1} = var1_v(var1_c); 
  var_val{2} = var2_v(var2_c); % learning rate for pfc 
  
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_brx = runBRXvar_Set(totalTrials, var_strings, var_val);
  fprintf('completed\n');
   
  BrxVar.TE(var1_c,var2_c,:) = [subj_sim_brx.TE];
  BrxVar.PRSRE(var1_c,var2_c,:) = [subj_sim_brx.PRSRE];
  BrxVar.PRE(var1_c,var2_c,:) = [subj_sim_brx.PRE];
  BrxVar.PRU(var1_c,var2_c,:) = [subj_sim_brx.PRU];
  %BrxVar.BRE(str_c,var2_c,:) = [subj_sim_brx.BRE];
  
  BrxVar.P1(var1_c,var2_c,:) = [subj_sim_brx.P1];
  BrxVar.P3(var1_c,var2_c,:) = [subj_sim_brx.P3];
  
  BrxVar.RT(var1_c,var2_c,:) = [subj_sim_brx.RT];
  BrxVar.RTcorr(var1_c,var2_c,:) = [subj_sim_brx.RTcorr];
  BrxVar.RTincorr(var1_c,var2_c,:) = [subj_sim_brx.RTincorr];
  
  BrxVar.trials(var1_c,var2_c,:) = [subj_sim_brx.trials];
  
  runTrialx = runTrialx + 1;
 
 end
end

end