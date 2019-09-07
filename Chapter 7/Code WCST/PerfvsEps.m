% Returns a structure where 
% epsilon_pfc has been changed and returns the 
% three params of ex-gaussian fit
%  
% PerfvsEpsStr = PerfvsEps([0.0:0.1:0.8],5,'str');
% PerfvsEpsPfc = PerfvsEps([0.0:0.1:0.8],5,'pfc');
  
function PerfvsEps = PerfvsEps(epsilon_v,num_trials,eps_type)

for ii = 1:length(epsilon_v) 
 
 switch eps_type 
     case 'pfc'
        subj_sim_wcst = runWCST_Set(num_trials,'epsilon_pfc', epsilon_v(ii));
     case 'str'
        subj_sim_wcst = runWCST_Set(num_trials,'epsilon_str', epsilon_v(ii));
 end
 
 [RTSimfit] = fitRTAllSimSubjectsData(subj_sim_wcst);
 
 %for ss = 1:length(RTSimfit)
  
   switch eps_type 
     case 'pfc'
      PerfvsEps(ii).eps_pfc = epsilon_v(ii);
       
     case 'str'
      PerfvsEps(ii).eps_str = epsilon_v(ii);
      
   end 
   
  %% RTs
  PerfvsEps(ii).untimed.all(1) = RTSimfit.untimed.all.mu;
  PerfvsEps(ii).untimed.all(2) = RTSimfit.untimed.all.sigma;
  PerfvsEps(ii).untimed.all(3) = RTSimfit.untimed.all.tau;
  
  %% Errors
  PerfvsEps(ii).TE = subj_sim_wcst.TE;
  PerfvsEps(ii).PE = subj_sim_wcst.PE;
  PerfvsEps(ii).SL3 = subj_sim_wcst.SL3;
  PerfvsEps(ii).RTmedian = nanmedian(subj_sim_wcst.RT);
  
 %end

end

end 