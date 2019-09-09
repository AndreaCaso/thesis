%% Load cards deck
createDeck;

%% Initialise Generic Variables 

f_sampl = 0.05; % sample frequency
timeLength = 1400; % in seconds
timeSteps = round(timeLength/f_sampl) + 1;
schemaNum = 7; % numbers of cortical schemas 

%extPFC = 0.5; %0.5 base

pfcNoise = 0.01; % Increases SL mostly
envNoise = 0.01;    

decay_constant = 0.6; %0.6 to 1 is smoother
trial = 0;
biasValue = 0.465; %0.5 - Decreases SL mostly

%% Initialise Basal Ganglia and Schema (premotor/parietal) variables
  
subTitleSchemaPFC = {'Cognitive Schema: Sort by Colour','Cognitive Schema: Sort by Number','Cognitive Schema: Sort by Shape'};
subTitleSchemaSMA = {'Motor Schema: Put down on pile 1','Motor Schema: Put down on pile 2','Motor Schema: Put down on pile 3','Motor Schema: Put down on pile 4'};

% Sigmoid look closer to the straight
% line bounded from -1 to 

alpha_sma = 8.72; 
alpha_pfc = 8.72; 

alpha_stn = 8.57;
alpha_gpi = 8.57;
alpha_gpe = 8.57; 
alpha_thal = 8.57; % 8.57 

alpha_str_pfc = 8.58*(ones(1,3)); %8.58 INCREASES NPE
alpha_str_sma = 8.58*(ones(1,4)); %8.58

beta_thal = 0.44; %0.4 Decreasing improve general performance
                  %Increasing it augment SL errors

beta_sma = 0.50*(ones(1,4)); % 0.5
beta_pfc = 0.50*(ones(1,3)); % 0.5

% in the channel-only version 
% this values are 0.5

% Associative (Cognitive) striatum

beta_str_pfc = 0.5*(ones(1,3));  %0.5 NORMAL DA

beta_stn_pfc = 0.3*(ones(1,3)); % 0.3
beta_gpe_pfc = 0.25*(ones(1,3)); % 0.2
beta_gpi_pfc = 0.25*(ones(1,3)); % 0.2

% Motor striatum

beta_str_sma = 0.5*(ones(1,4));  %0.5 NORMAL DA

beta_stn_sma = 0.3*(ones(1,4)); 
beta_gpe_sma = 0.25*(ones(1,4)); % 0.2
beta_gpi_sma = 0.25*(ones(1,4)); % 0.2

u_ST1_SMA = zeros(4,timeSteps);
u_ST2_SMA = zeros(4,timeSteps);
u_STN_SMA = zeros(4,timeSteps);
u_GPe_SMA = zeros(4,timeSteps);
u_GPi_SMA = zeros(4,timeSteps);
u_THAL_SMA = zeros(4,timeSteps);

u_ST1_PFC = zeros(3,timeSteps);
u_ST2_PFC = zeros(3,timeSteps);
u_STN_PFC = zeros(3,timeSteps);
u_GPe_PFC = zeros(3,timeSteps);
u_GPi_PFC = zeros(3,timeSteps);
u_THAL_PFC = zeros(3,timeSteps);

u_SMA = zeros(4,timeSteps);
u_PFC = zeros(3,timeSteps);

a_ST1_SMA = zeros(4,timeSteps);
a_ST2_SMA = zeros(4,timeSteps);
a_STN_SMA = zeros(4,timeSteps);
a_GPe_SMA = zeros(4,timeSteps);
a_GPi_SMA = zeros(4,timeSteps);
a_THAL_SMA = zeros(4,timeSteps);
a_THAL_SMA = zeros(4,timeSteps);

a_ST1_PFC = zeros(3,timeSteps);
a_ST2_PFC = zeros(3,timeSteps);
a_STN_PFC = zeros(3,timeSteps);
a_GPe_PFC = zeros(3,timeSteps);
a_GPi_PFC = zeros(3,timeSteps);
a_THAL_PFC = zeros(3,timeSteps);

a_SMA = zeros(4,timeSteps);
a_PFC = zeros(3,timeSteps);

o_ST1_SMA = zeros(4,timeSteps);
o_ST2_SMA = zeros(4,timeSteps);
o_STN_SMA = zeros(4,timeSteps);
o_GPe_SMA = zeros(4,timeSteps);
o_GPi_SMA = zeros(4,timeSteps);
o_THAL_SMA = zeros(4,timeSteps);
o_THAL_SMA = zeros(4,timeSteps);

o_ST1_PFC = zeros(3,timeSteps);
o_ST2_PFC = zeros(3,timeSteps);
o_STN_PFC = zeros(3,timeSteps);
o_GPe_PFC = zeros(3,timeSteps);
o_GPi_PFC = zeros(3,timeSteps);
o_THAL_PFC = zeros(3,timeSteps);

o_SMA = zeros(4,timeSteps);
o_PFC = zeros(3,timeSteps);

w_SMA = zeros(schemaNum,timeSteps);
w_PFC = zeros(schemaNum,timeSteps);

W_STN = 1;  
W_ST1_GPi = -1; %-1
W_ST2_GPe = -1; %-1
W_STN_GPe = 0.9;  %0.9
W_STN_GPi = 0.9;  %0.9
W_GPe_STN = -1; % -1
W_GPe_GPi = -0.3; %-0.3
W_THAL = 1;
 
%% Initialise Wsch matrix in hierarchical way
% Remember that it is task dependent

% Schema inter-excitation (weight matrix Wsch). 
% Wsch indices are to-from
% This allows the implementation of a learning mechanism

Wsma = +0.00*ones(4,4); %0 ZERO !
Wpfc = +0.00*ones(3,3); %0 ZERO ! increases TE and NPE
           
%self-activation of the channel (mild)
Wsma = Wsma + diag(+0.2*ones(1,size(Wsma,2)));
Wpfc = Wpfc + diag(+0.2*ones(1,size(Wpfc,2))); %Increases SL

%self-energising schemas after the threshold engThr
engThr = 0.7; %0.7; % 0.7

wExt  = 0.635;  %0.6
             % this parameter is essential for
             % the excitation of motor schemas
             % from the environment
extBase = 0.27; %0.27 Decreased SL (?)

Wparent = zeros(4,3); % initialise to zero 
wPar = 0.831;  % 0.8 this parameter is essential
             % for the communication between cognitive
             % schemas (rules) and motor schemas
parBase = 0.23; 

% All the other weights are null

%% Initialise External Matrix (EXT)

o_EXT_SMA = 0.5*ones(4, timeSteps) + pfcNoise*randn(4, timeSteps);
o_EXT_PFC = 0.5*ones(3, timeSteps) + pfcNoise*randn(3, timeSteps);

%% Initialise experiment variables
%ruleSet = ''; 

correctTrial = zeros(1,64);
catNum = 1;
catNumTrial = zeros(1,64);
category = ['c' 's' 'n' 'c' 's' 'n']; % Colour - Form - Number - Colour - Form - Number

% ruleSet = zeros(1,64);                      
featureTrial = cell(1,64); 
% cnfo : c if it matches the colour, cn if it matches the number etc.

changeAfterCorrect = 10;
PPCerrors = 0; % Pers. Previous Cat. (Stuss)
PPRerrors = 0; % Pers. Previous Resp. (Stuss)
PRerrors = zeros(1,64); % Pers. Responses (Heaton)

PEerrors = zeros(1,64); % Pers. Errors (Heaton)

TEerrors = 0;
NPEerrors = 0;

SL3errors = zeros(1,64); % set loss errors (Stuss)
SL5errors = zeros(1,64); % set loss errors (Heaton)

TFC = NaN; % trial to first category (Heaton)
LTL = NaN;  % learning to learn (Heaton)

% Counters
correctCounter = 0;
decCounter = 0;
decCounterTot = zeros(1,64);
SMAdec = 0;