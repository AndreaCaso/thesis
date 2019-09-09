%% Run WCST simulation in multiple subjects
% The optional argument changes the specified variable to the 
% requested one
% subj_sim_wcst = runWCSTvar_Set(5,{'extPFC'},{0.8});
% subj_sim_wcst = runWCSTvar_Set(5,{'weights.w_STIM_PRES','weights.w_RULE'},{0.7,0.6});

function subj_sim_wcst = runWCSTvar_Set(subjects_tot,varargin)
%% Define number of trials
if nargin == 0 
   subjects_tot = 2; % set the total number of counter.trial_nums
end 

%% Print initial time
fprintf('Simulating WCST\n');
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'));
    
for subject_num = 1:subjects_tot

 fprintf('Subject %1.0f out of %1.0f...\n ',subject_num, subjects_tot);
 
 %% Initialise, run one trial and register variables
 initialiseWCST;
 
 if nargin > 1
 
  var_string = varargin{1};
  var_value = varargin{2};
 
  % Applies the values to the variables
  for vars_num = 1:length(var_value)
   eval(strcat( var_string{vars_num}, '=', num2str(var_value{vars_num}) ,';'));
   fprintf(' %s is set to %1.2f \n ', var_string{vars_num}, (var_value{vars_num}));
  end
  
 end
 
 %fprintf( 'epsilon_pfc = %1.2f \n',epsilon.eps_pfc);
  
 runWCST;        % Run one subject

 subj_sim_wcst(subject_num).TE = sum(performances.TE);
 subj_sim_wcst(subject_num).PE = sum(performances.PE);
 subj_sim_wcst(subject_num).SL3 = sum(performances.SL3);
  
 subj_sim_wcst(subject_num).RT = (performances.RT);
 subj_sim_wcst(subject_num).RTcorr = (performances.RTcorr);
 subj_sim_wcst(subject_num).RTincorr = (performances.RTincorr);
 
 subj_sim_wcst(subject_num).trials = (counter.trial_num);
 
 fprintf('completed\n');


end

%% Print results and saves

 fprintf('\n Simulation WCST completed\n');
 fprintf('Ending time: %s\n', datestr(now,'HH:MM'));
 
 %{
 fprintf('\n'); 
 fprintf('Total Errors in %1.0f subjects: (M = %1.1f, SD = %1.1f) \n', subjects_tot, mean([subj_sim_WCST.TE]), std([subj_sim_WCST.TE]));
 fprintf('\n');
 %}
end

