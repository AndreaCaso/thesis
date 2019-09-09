
%% TE - Total Error  

performances.TE = sum(counter.correct_counter_vector==0);
performances.TEp = performances.TE/num_trials*100;

PRE = zeros(1,counter.trial_num);
PRU = zeros(1,counter.trial_num);
PRSRE = zeros(1,counter.trial_num);

% Merged to mimic what B&S did (1996)
P1 = zeros(1,counter.trial_num);
P3 = zeros(1,counter.trial_num);

for cc = 2:length(responses)
  
  %% Preceding response error (PRE) 
  % the subjects clicks on the current circle (previous targets)
  % and not on the expected one
  performances.PRE = 0;
  if (responses(cc) == stimuli(cc,2))
    PRE(cc) = 1;
  end 
  
  %% Perseverative response Error (PRSRE) - same response
  % The error is encountered whenever the
  % subject selects the same previous response
  performances.PRSRE = 0;
  if responses(cc) == responses(cc-1) && responses(cc) ~= 0
     PRSRE(cc) = 1;
  end
  performances.PRSRE = sum(PRSRE);
  
  %% Perseverative rule PRU and percentage PRUp
  % And perseverative trials
  
  performances.PRU = 0;
  PRU = ([NaN;responses] == stimuli(:,3) & (stimuli(:,3) ~= 0));
  performances.PRU = nansum(PRU);

end

%% Count PRE for first response as well
if responses(1) == 1
   PRE(1) = 1;
end
performances.PRE = sum(PRE);

%% P1 and P3
for cc = 1:length(P1)
 P1(cc) = PRSRE(cc) || PRE(cc) || PRU(cc);
end
performances.P1 = nansum(P1); 
performances.P3 = nansum(performances.TE) - performances.P1;

%% RT (median)
RTdistr = counter.trial_num_time_tot;
performances.RT = nanmedian(RTdistr);

idx = find(counter.correct_counter_vector==1);
idx = idx(idx<50);
performances.RTcorr = nanmedian(RTdistr(idx+1));

idx = find(counter.correct_counter_vector==0);
idx = idx(idx<50);
performances.RTincorr = nanmedian(RTdistr(idx+1));
