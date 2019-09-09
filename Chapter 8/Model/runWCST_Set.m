%% Run WCST simulation in multiple subjects
% The optional argument changes the specified variable to the 
% requested one
% subj_sim_wcst = runWCST_Set(5,0.45, 0.10);
% subj_sim_wcst = runWCST_Set(5,0.50, 0.05);

function subj_sim_wcst = runWCST_Set(subjects_tot,varargin)
%% Define number of trials
if nargin == 0
   subjects_tot = 2; % set the total number of counter.trial_nums
end 

%% Print initial time
fprintf('Simulating WCST\n')
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))

 for subject_num = 1:subjects_tot

 fprintf('Subject %1.0f out of %1.0f... ',subject_num, subjects_tot);
 
 %% Initialise, run one trial and register variables
 initialiseWCST;
 
 epsilon.eps_str = varargin{1};
 epsilon.eps_pfc = varargin{2};
 
 %fprintf('\nepsilon_str = %1.2f \n',epsilon.eps_str);
 %fprintf('epsilon_pfc = %1.2f \n',epsilon.eps_pfc);
  
 runWCST;        % Run one subject

 subj_sim_wcst(subject_num).CC = sum(performances.CC);
 subj_sim_wcst(subject_num).LTL = sum(performances.LTL); 
 
 subj_sim_wcst(subject_num).TE = sum(performances.TE);
 subj_sim_wcst(subject_num).PE = sum(performances.PE);
 subj_sim_wcst(subject_num).PR = sum(performances.PR);
 subj_sim_wcst(subject_num).NPE = sum(performances.NPE);

 subj_sim_wcst(subject_num).SL5 = sum(performances.SL5);
 subj_sim_wcst(subject_num).SL3 = sum(performances.SL3);

 subj_sim_wcst(subject_num).RTs = (counter.trial_num_time_tot);
 subj_sim_wcst(subject_num).RTall = median(performances.RT);
 subj_sim_wcst(subject_num).RTcorr = median(performances.RTcorr);
 subj_sim_wcst(subject_num).RTincorr = median(performances.RTincorr);
  
 subj_sim_wcst(subject_num).RT_SL3 = (performances.RT_SL3);
 subj_sim_wcst(subject_num).RT_SL5 = (performances.RT_SL5);
 subj_sim_wcst(subject_num).RT_PE = (performances.RT_PE);

 subj_sim_wcst(subject_num).trial_num = counter.trial_num;
 
 fprintf('completed\n');

 save('subj_sim_wcst.mat','subj_sim_wcst','-append');

end

%% Print results and save

 fprintf('Simulation WCST completed\n');
 fprintf('Ending time: %s\n', datestr(now,'HH:MM'))

 fprintf('\n'); 
 fprintf('Categories completed (Heaton) in %1.0f subjects: (M = %1.1f, SD = %1.1f) \n', subjects_tot, mean([subj_sim_wcst.CC]), std([subj_sim_wcst.CC]));
 fprintf('Total Errors (Heaton) in %1.0f subjects: (M = %1.1f, SD = %1.1f) \n', subjects_tot, mean([subj_sim_wcst.TE]), std([subj_sim_wcst.TE]));
 fprintf('Perseverative Errors (Heaton) in %1.0f subjects: (M = %1.1f, SD = %1.1f) \n', subjects_tot, mean([subj_sim_wcst.PE]), std([subj_sim_wcst.PE]));
 fprintf('Non-perseverative Errors (Heaton) in %1.0f subjects: (M = %1.1f, SD = %1.1f) \n', subjects_tot, mean([subj_sim_wcst.NPE]), std([subj_sim_wcst.NPE]));
 fprintf('Set Loss Errors (Stuss) in %1.0f subjects: (M = %1.1f, SD = %1.1f) \n', subjects_tot, mean([subj_sim_wcst.SL3]), std([subj_sim_wcst.SL3]));
 fprintf('\n');

 save('subj_sim_wcst.mat','subj_sim_wcst','-append');
end

