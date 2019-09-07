%% Declare variables

%% Load cards deck
create_stimuli;
lstim = length(stimuli);

%% Initialise Generic Variables 

f_sampl = 0.1; % sample frequency
timeLength = 9000; % 1500
timeSteps = round(timeLength/f_sampl) + 1;
 
extPFC = 1.3378; %controls the external to the cog schema: Last 0.8
extNoise = 0.30; % controls external (uniform noise), to PFC and to SMA

decay_constant = 0.6; %0.6 to 1 is smoother

pfc.actPFC = zeros(lstim+1,3);   %represents pfc.o_PFC when reward.reward_value.reward.reward_value_value has come

pfc.pfcNoise = 0.30*unifrnd(-1,1,1,lstim+1);
sma.smaNoise = 0.30*unifrnd(-1,1,4,timeSteps);

thresholds.dynamic = normrnd(5e4,0.05*5e4,1,timeSteps);
thresholds.static = 0.5;

pfc.pred_act = zeros(lstim+1,3);
pfc.entropyPFC = zeros(lstim+1,3);

reward.reward_value = zeros(lstim+1,3);
reward.TDV = zeros(lstim+1,3);
reward.discount_TDV = 0.0946; %gamma value in temporal difference learning

epsilon.eps_str = 0.3733; % learning rate for STRIATUM 
epsilon.eps_pfc = 0.3023; % learning rate for PFC 

%% Initialise Basal Ganglia and Schema (premotor/parietal) variables
  
pfc.schema_names = {'Cognitive Schema: Sort by Colour','Cognitive Schema: Sort by Number','Cognitive Schema: Sort by Shape'};
sma.schema_names = {'Motor Schema: Put down on pile 1','Motor Schema: Put down on pile 2','Motor Schema: Put down on pile 3','Motor Schema: Put down on pile 4'};

% Saturation functions

satfnc.alpha_sma = 5.8365; 
satfnc.alpha_pfc = 10*(ones(1,3));

satfnc.alpha_stn = 9;
satfnc.alpha_gpi = 9;
satfnc.alpha_gpe = 9; 
satfnc.alpha_thal = 9; 

satfnc.alpha_str_pfc = 9.5*(ones(1,3)); 
satfnc.alpha_str_sma = 9.5*(ones(1,4)); 

satfnc.beta_thal = 0.40; 

satfnc.beta_sma = 0.40*(ones(1,4)); 
satfnc.beta_pfc = [0.50 0.50 0.50];

satfnc.beta_str_pfc = [0.49 0.50 0.51];
satfnc.beta_str_pfc = satfnc.beta_str_pfc(randperm(3));

satfnc.beta_stn_pfc = 0.30*(ones(1,3)); 
satfnc.beta_gpe_pfc = 0.25*(ones(1,3)); 
satfnc.beta_gpi_pfc = 0.25*(ones(1,3)); 

satfnc.beta_str_sma = 0.50*(ones(1,4));  

satfnc.beta_stn_sma = 0.30*(ones(1,4));  % 30
satfnc.beta_gpe_sma = 0.25*(ones(1,4)); % 0.2
satfnc.beta_gpi_sma = 0.25*(ones(1,4)); % 0.2

sma.u_ST1_SMA = zeros(4,timeSteps);
sma.u_ST2_SMA = zeros(4,timeSteps);
sma.u_STN_SMA = zeros(4,timeSteps);
sma.u_GPe_SMA = zeros(4,timeSteps);
sma.u_GPi_SMA = zeros(4,timeSteps);
sma.u_THAL_SMA = zeros(4,timeSteps);

pfc.u_ST1_PFC = zeros(3,timeSteps);
pfc.u_ST2_PFC = zeros(3,timeSteps);
pfc.u_STN_PFC = zeros(3,timeSteps);
pfc.u_GPe_PFC = zeros(3,timeSteps);
pfc.u_GPi_PFC = zeros(3,timeSteps);
pfc.u_THAL_PFC = zeros(3,timeSteps);

sma.u_SMA = zeros(4,timeSteps);
pfc.u_PFC = zeros(3,timeSteps);

sma.a_ST1_SMA = zeros(4,timeSteps);
sma.a_ST2_SMA = zeros(4,timeSteps);
sma.a_STN_SMA = zeros(4,timeSteps);
sma.a_GPe_SMA = zeros(4,timeSteps);
sma.a_GPi_SMA = zeros(4,timeSteps);
sma.a_THAL_SMA = zeros(4,timeSteps);

pfc.a_ST1_PFC = zeros(3,timeSteps);
pfc.a_ST2_PFC = zeros(3,timeSteps);
pfc.a_STN_PFC = zeros(3,timeSteps);
pfc.a_GPe_PFC = zeros(3,timeSteps);
pfc.a_GPi_PFC = zeros(3,timeSteps);
pfc.a_THAL_PFC = zeros(3,timeSteps);

sma.a_SMA = zeros(4,timeSteps);
pfc.a_PFC = zeros(3,timeSteps);

sma.o_ST1_SMA = zeros(4,timeSteps);
sma.o_ST2_SMA = zeros(4,timeSteps);
sma.o_STN_SMA = zeros(4,timeSteps);
sma.o_GPe_SMA = zeros(4,timeSteps);
sma.o_GPi_SMA = zeros(4,timeSteps);
sma.o_THAL_SMA = zeros(4,timeSteps);
sma.o_THAL_SMA = zeros(4,timeSteps);

pfc.o_ST1_PFC = zeros(3,timeSteps);
pfc.o_ST2_PFC = zeros(3,timeSteps);
pfc.o_STN_PFC = zeros(3,timeSteps);
pfc.o_GPe_PFC = zeros(3,timeSteps);
pfc.o_GPi_PFC = zeros(3,timeSteps);
pfc.o_THAL_PFC = zeros(3,timeSteps);

sma.o_SMA = zeros(4,timeSteps);
pfc.o_PFC = zeros(3,timeSteps);

sma.w_SMA = zeros(4,timeSteps);
pfc.w_PFC = zeros(3,timeSteps);

bg.W_STN = 1.2;  
bg.W_ST1_GPi = -1; %-1
bg.W_ST2_GPe = -1; %-1
bg.W_STN_GPe = 0.9;  %0.9
bg.W_STN_GPi = 0.9;  %0.9
bg.W_GPe_GPi = -0.3; %-0.3

weights.w_STIM_PRES  = 0.3660; 
             % this parameter is essential for
             % the excitation of motor schemas
             % from the environment (w_STIM_PRES)
weights.w_STIM_BASE = 0.2367; %0.20  (w_STIM_BASE)

weights.w_RULE_BASED = zeros(4,3); % TO-FROM parent to child schemas
weights.w_RULE_PRES = 1.2792;   % this parameter is essential
             % for the communication between cognitive
             % schemas (rules) and motor schemas
             % decrease ups TE and NPE
             % w_RULE_PRES
weights.w_RULE_BASE = 0.00; %0.20 w_RULE_BASE

% All the other weights are null

%% Initialise External Matrix (EXT)
o_EXT_SMA = extNoise*ones(4, timeSteps) + sma.smaNoise;

counter.tt_trial_num = zeros(1,lstim);
category = ['c' 's' 'n' 'c' 's' 'n' 'c' 's' 'n' 'c' 's' 'n' 'c' 's' 'n' 'c' 's' 'n' 'c' 's']; % Colour - Form - Number - Colour - Form - Number

% ruleSet = zeros(1,lstim);                      
counter.feature_trial = cell(1,lstim); 
% cnfo : c if it matches the colour, cn if it matches the number etc.

changeAfterCorrect = 10;

performances.CC = 1;
performances.CCTrial = zeros(1,lstim);
performances.PPC = 0; % Pers. Previous Cat. (Stuss)

performances.PPR = 0; % Pers. Previous Resp. (Stuss)
performances.PR = zeros(1,lstim); % Pers. Responses (Heaton)
performances.PE = zeros(1,lstim); % Pers. Errors (Heaton)
performances.TE = 0;
performances.NPE = 0;

performances.SL3 = zeros(1,lstim); % set loss errors (Stuss)
performances.SL5 = zeros(1,lstim); % set loss errors (Heaton)

performances.TFC = NaN; % counter.trial_num to first category (Heaton)
performances.LTL = NaN;  % learning to learn (Heaton)

performances.RT_SL5 = nan(1,lstim);  
performances.RT_SL3 = nan(1,lstim);  
performances.RT_PE = nan(1,lstim);

% Counters
counter.correct_counter = 0;
counter.correct_counter_vector = zeros(1,lstim);
counter.trial_num = 0;
counter.trial_num_time = 0;
counter.trial_num_timePFC = 0;
counter.trial_num_time_tot = zeros(1,lstim);
counter.area_sma = 0;
counter.area_pfc = 0;

SMAdrift = zeros(4,4);
counter.tt_trial_num = zeros(1,lstim);