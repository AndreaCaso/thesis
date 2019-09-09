%% Declare variables

%% Load cards deck
create_stimuli;

%% Initialise Generic Variables 
f_sampl = 0.05; % sample frequency
timeLength = 1500; % 1500
timeSteps = round(timeLength/f_sampl) + 1;

actW = 0;
newRule = 1;
num_trials = 50; % total number of trials
num_circles = 9; % total number of circle (SMA)
num_rules = 5; % total number of rules (PFC)

area_threshold = 3e4; %3e4

rules_set{1} = [1 2 3 4 5 6 7 8 9 1];
rules_set{2} = [9 8 7 6 5 4 3 2 1 9];
rules_set{3} = [1 5 1 5 1 5 1 5 1 5];
rules_set{4} = [9 7 5 3 1 8 6 4 2 9];
rules_set{5} = randi([1 9], 1,10);

responses = nan(num_trials, 1);

extPFC = 0.8833; %down this and up PRSRE
extNoise = 0.20; % controls external (uniform noise), to PFC and to SMA

decay_constant = 0.6; %0.6 to 1 is smoother

pfc.actPFC = zeros(num_trials,num_rules);   %represents pfc.o_PFC when reward.reward_value.reward.reward_value_value has come

pfc.pfcNoise = 0.20*randn(1,num_trials);
sma.smaNoise = 0.20*randn(num_trials,timeSteps);

pfc.pred_act = zeros(num_trials,num_rules);
pfc.entropyPFC = zeros(num_trials,num_rules);
pfc.indexPFC = 5*ones(1,num_trials);

sma.pred_act = zeros(num_trials,num_circles);
sma.entropySMA = zeros(num_trials,num_circles);
sma.indexSMA = 1*ones(1,num_circles);

reward.reward_value = zeros(num_trials,num_rules);
reward.TDV = zeros(num_trials,num_rules);
reward.discount_TDV = 0.0707; 

epsilon.eps_str = 0.5; %0.6008; % learning rate for STRIATUM 
epsilon.eps_pfc = 0.25; %0.2809; % learning rate for PFC  

%% Initialise Basal Ganglia and Schema (premotor/parietal) variables
  
pfc.schema_names = {'Clockwise','Anticlockwise','Alternate 5-1', 'Anticlockwise -2','Any Other'};
sma.schema_names = {'1','2','3','4','5','6','7','8','9'};

% Saturation functions

satfnc.alpha_sma = 10; 
satfnc.alpha_pfc = 10*(ones(1,num_rules)); %10

satfnc.alpha_stn = 9;
satfnc.alpha_gpi = 9;
satfnc.alpha_gpe = 9; 
satfnc.alpha_thal = 9; 

satfnc.alpha_str_pfc = 9.5*(ones(1,num_rules)); 
satfnc.alpha_str_sma = 9.5*(ones(1,num_circles)); 

satfnc.beta_thal = 0.40; %increasing it doesn't change PRU much

satfnc.beta_sma = 0.40*ones(1,num_circles); %.05 !!!!
satfnc.beta_pfc = 0.50*ones(1,num_rules);

satfnc.beta_str_pfc = 0.50*ones(1,num_rules);

satfnc.beta_stn_pfc = 0.30*ones(1,num_rules); 
satfnc.beta_gpe_pfc = 0.25*ones(1,num_rules); 
satfnc.beta_gpi_pfc = 0.25*ones(1,num_rules); 

satfnc.beta_str_sma = 0.50*ones(1,num_circles);  % 0.50

satfnc.beta_stn_sma = 0.30*ones(1,num_circles);  
satfnc.beta_gpe_sma = 0.25*ones(1,num_circles);  
satfnc.beta_gpi_sma = 0.25*ones(1,num_circles);  

sma.u_ST1_SMA = zeros(num_circles,timeSteps);
sma.u_ST2_SMA = zeros(num_circles,timeSteps);
sma.u_STN_SMA = zeros(num_circles,timeSteps);
sma.u_GPe_SMA = zeros(num_circles,timeSteps);
sma.u_GPi_SMA = zeros(num_circles,timeSteps);
sma.u_THAL_SMA = zeros(num_circles,timeSteps);

pfc.u_ST1_PFC = zeros(num_rules,timeSteps);
pfc.u_ST2_PFC = zeros(num_rules,timeSteps);
pfc.u_STN_PFC = zeros(num_rules,timeSteps);
pfc.u_GPe_PFC = zeros(num_rules,timeSteps);
pfc.u_GPi_PFC = zeros(num_rules,timeSteps);
pfc.u_THAL_PFC = zeros(num_rules,timeSteps);

sma.u_SMA = zeros(num_circles,timeSteps);
pfc.u_PFC = zeros(num_rules,timeSteps);

sma.a_ST1_SMA = zeros(num_circles,timeSteps);
sma.a_ST2_SMA = zeros(num_circles,timeSteps);
sma.a_STN_SMA = zeros(num_circles,timeSteps);
sma.a_GPe_SMA = zeros(num_circles,timeSteps);
sma.a_GPi_SMA = zeros(num_circles,timeSteps);
sma.a_THAL_SMA = zeros(num_circles,timeSteps);

pfc.a_ST1_PFC = zeros(num_rules,timeSteps);
pfc.a_ST2_PFC = zeros(num_rules,timeSteps);
pfc.a_STN_PFC = zeros(num_rules,timeSteps);
pfc.a_GPe_PFC = zeros(num_rules,timeSteps);
pfc.a_GPi_PFC = zeros(num_rules,timeSteps);
pfc.a_THAL_PFC = zeros(num_rules,timeSteps);

sma.a_SMA = zeros(num_circles,timeSteps);
pfc.a_PFC = zeros(num_rules,timeSteps);

sma.o_ST1_SMA = zeros(num_circles,timeSteps);
sma.o_ST2_SMA = zeros(num_circles,timeSteps);
sma.o_STN_SMA = zeros(num_circles,timeSteps);
sma.o_GPe_SMA = zeros(num_circles,timeSteps);
sma.o_GPi_SMA = zeros(num_circles,timeSteps);
sma.o_THAL_SMA = zeros(num_circles,timeSteps);
sma.o_THAL_SMA = zeros(num_circles,timeSteps);

pfc.o_ST1_PFC = zeros(num_rules,timeSteps);
pfc.o_ST2_PFC = zeros(num_rules,timeSteps);
pfc.o_STN_PFC = zeros(num_rules,timeSteps);
pfc.o_GPe_PFC = zeros(num_rules,timeSteps);
pfc.o_GPi_PFC = zeros(num_rules,timeSteps);
pfc.o_THAL_PFC = zeros(num_rules,timeSteps);

sma.o_SMA = zeros(num_circles,timeSteps);
pfc.o_PFC = zeros(num_rules,timeSteps);

sma.w_SMA = zeros(num_circles,timeSteps);
pfc.w_PFC = zeros(num_rules,timeSteps);

bg.W_STN = 1.2;  
bg.W_ST1_GPi = -1; %-1
bg.W_ST2_GPe = -1; %-1
bg.W_STN_GPe = 0.9;  %0.9
bg.W_STN_GPi = 0.9;  %0.9
bg.W_GPe_GPi = -0.3; %-0.3

weights.w_STIM_PRES  = 0.4539;  %0.70
             % this parameter is essential for
             % the excitation of motor schemas
             % from the environment (w_STIM_PRES)
weights.w_STIM_BASE = 0.2924; %0.20  (w_STIM_BASE)

% TO-FROM parent to child schemas
weights.w_RULE_BASE = -0.00; %Basic excitation/inhibition
weights.w_RULE_BASED = weights.w_RULE_BASE*eye(num_circles,num_rules); %default 

weights.w_RULE_PRES = 1.0476;  % this parameter is essential
             % for the communication between cognitive
             % schemas (rules) and motor schemas
             % decrease ups TE and NPE
             % w_RULE_PRES

% All the other weights are null

%% Initialise External Matrix (EXT)
o_EXT_SMA = zeros(num_trials, timeSteps);

counter.tt_trial_num = zeros(1,num_trials);

performances.TE = 0;
performances.PRE = 0; % Preceding Response
performances.PRSR = 0; % Perseveration of Response
performances.PRU = 0;  % Perseveration of Rule

% Counters
counter.correct_counter = 0;
counter.correct_counter_vector = nan(1,num_trials);
counter.trial_num = 0;
counter.trial_num_time = 0;
counter.trial_num_timePFC = 0;
counter.trial_num_time_tot = nan(1,num_trials);
counter.area_sma = 0;
counter.area_pfc = 0;

counter.tt_trial_num = nan(1,num_trials);