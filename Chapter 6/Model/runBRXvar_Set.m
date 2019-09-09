%% Run WCST simulation in multiple subjects
% The optional argument changes the specified variable to the 
% requested one
% subj_sim_brx = runBRXvar_Set(5,'weights.w_STIM_PRES',0.7);
% subj_sim_brx = runBRXvar_Set(5,{'weights.w_STIM_PRES','weights.w_RULE'},{0.7,0.6});

function subj_sim_brx = runBRXvar_Set(subjects_tot,varargin)
%% Define number of trials
if nargin == 0
   subjects_tot = 2; % set the total number of counter.trial_nums
end 

%% Print initial time
fprintf('Simulating BRX\n');
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'));
    
for subject_num = 1:subjects_tot

 fprintf('Subject %1.0f out of %1.0f...\n ',subject_num, subjects_tot);
 
 %% Initialise, run one trial and register variables
 initialiseBRX;
 var_string = varargin{1};
 var_value = varargin{2};
 
 for vars_num = 1:length(var_value)
  eval(strcat( var_string{vars_num}, '=', num2str(var_value{vars_num}) ,';'));
  fprintf(' %s is set to %1.2f \n ', var_string{vars_num}, (var_value{vars_num}));
 end
 
 %fprintf( 'epsilon_pfc = %1.2f \n',epsilon.eps_pfc);
  
 runBRX;        % Run one subject

 subj_sim_brx(subject_num).TE = (performances.TE);
 subj_sim_brx(subject_num).PRE = (performances.PRE);
 subj_sim_brx(subject_num).PRU = (performances.PRU);
 subj_sim_brx(subject_num).PRSRE = (performances.PRSRE);
 
 subj_sim_brx(subject_num).P1 = (performances.P1);
 subj_sim_brx(subject_num).P3 = (performances.P3);
  
 subj_sim_brx(subject_num).RT = (performances.RT);
 subj_sim_brx(subject_num).RTcorr =  (performances.RTcorr);
 subj_sim_brx(subject_num).RTincorr = (performances.RTcorr);
 
 subj_sim_brx(subject_num).trials = (counter.trial_num);
 
 fprintf('completed\n');

 %save('subj_sim_brx.mat','subj_sim_brx','-append');

end

%% Print results and savez

 fprintf('\n Simulation BRX completed\n');
 fprintf('Ending time: %s\n', datestr(now,'HH:MM'));
 
 %{
 fprintf('\n'); 
 fprintf('Total Errors in %1.0f subjects: (M = %1.1f, SD = %1.1f) \n', subjects_tot, mean([subj_sim_brx.TE]), std([subj_sim_brx.TE]));
 fprintf('\n');
 %}
end

