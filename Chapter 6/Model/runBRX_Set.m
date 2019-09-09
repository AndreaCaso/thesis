%% Run WCST simulation in multiple subjects
% The optional argument changes the specified variable to the 
% requested one
% subj_sim_brx = runBRX_Set(5,0.05,0.1);

function subj_sim_brx = runBRX_Set(subjects_tot,varargin)
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
 
 epsilon.eps_str = varargin{1};
 epsilon.eps_pfc = varargin{2};
 
 if nargin == 4
    reward.discount_TDV = varargin{3};
 elseif nargin == 5
    reward.discount_TDV = varargin{3};
    extPFC = varargin{4};
 elseif nargin == 6
    reward.discount_TDV = varargin{3};
    extPFC = varargin{4}; 
    alpha_sma = varargin{5}; 
 elseif nargin == 7
    reward.discount_TDV = varargin{3};
    extPFC = varargin{4}; 
    alpha_sma = varargin{5}; 
    weights.w_STIM_PRES = varargin{6}; 
 end
 
 %fprintf('\nepsilon_str = %1.2f \n',epsilon.eps_str);
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

