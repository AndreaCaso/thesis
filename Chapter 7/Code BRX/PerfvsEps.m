% Returns a structure where 
% epsilon_pfc has been changed and returns the 
% three params of ex-gaussian fit
%  
% PerfvsEpsStr = PerfvsEps([0.0:0.1:0.7],5,'str');
% PerfvsEpsPfc = PerfvsEps([0.0:0.1:0.7],5,'pfc');
  
function PerfvsEps = PerfvsEps(epsilon_v,num_trials,eps_type)

for ii = 1:length(epsilon_v) 
 
 switch eps_type 
     case 'pfc'
        subj_sim_brx = runBRX_Set(num_trials,'epsilon_pfc', epsilon_v(ii));
     case 'str'
        subj_sim_brx = runBRX_Set(num_trials,'epsilon_str', epsilon_v(ii));
 end
 
  
   switch eps_type 
     case 'pfc'
      PerfvsEps(ii).eps_pfc = epsilon_v(ii);
       
     case 'str'
      PerfvsEps(ii).eps_str = epsilon_v(ii);
      
   end 
   
  %% Errors
  PerfvsEps(ii).TE = [subj_sim_brx.TE];
  PerfvsEps(ii).PRE = [subj_sim_brx.PRE];
  PerfvsEps(ii).PRU = [subj_sim_brx.PRU];
  PerfvsEps(ii).PRSRE = [subj_sim_brx.PRSRE];
  
  %% RTs
  PerfvsEps(ii).RT = [subj_sim_brx.RT];
  PerfvsEps(ii).RTcorr = [subj_sim_brx.RTcorr];
  PerfvsEps(ii).RTincorr = [subj_sim_brx.RTincorr];
 
end

end 