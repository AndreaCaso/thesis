%clear;

%% Initialise Generic Variables 

f_sampl = 0.1; % sample frequency
timeLength = 5e2; % in seconds
timeSteps = round(timeLength/f_sampl) - 1;
schemaNum = 3; % numbers of cortical schemas 

decay_constant = 0.6; %to 1 lis smoother

%% Initialise Basal Ganglia and Schema (premotor/parietal) variables

inputBG = zeros(schemaNum,timeSteps);  
subTitleSchema = {'Schema 1','Schema 2','Schema 3','Schema 4','Schema 5','Schema 6'};

% sigmoid look closer to the straight
% line bounded from 60 to +1

alpha_sma = 7;  % This value changes the distribution
alpha_str = 4; 
alpha_stn = 5;  
alpha_gpi = 5;  
alpha_gpe = 5; 
alpha_thal = 6;

beta_sma  = 0.5*(ones(1,schemaNum));
beta_str  = 0.5*(ones(1,schemaNum));
beta_thal = 0.4*(ones(1,schemaNum));

beta_stn = 0.3*(ones(1,schemaNum));
beta_gpe = 0.2*(ones(1,schemaNum));
beta_gpi = 0.2*(ones(1,schemaNum));

u_ST1 = zeros(schemaNum,timeSteps);
u_ST2 = zeros(schemaNum,timeSteps);
u_STN = zeros(schemaNum,timeSteps);
u_GPe = zeros(schemaNum,timeSteps);
u_GPi = zeros(schemaNum,timeSteps);
u_SMA = zeros(schemaNum,timeSteps);
u_THAL = zeros(schemaNum,timeSteps);

a_ST1 = zeros(schemaNum,timeSteps);
a_ST2 = zeros(schemaNum,timeSteps);
a_STN = zeros(schemaNum,timeSteps);
a_GPe = zeros(schemaNum,timeSteps);
a_GPi = zeros(schemaNum,timeSteps);
a_SMA = zeros(schemaNum,timeSteps);
a_THAL = zeros(schemaNum,timeSteps);

o_ST1 = zeros(schemaNum,timeSteps);
o_ST2 = zeros(schemaNum,timeSteps);
o_STN = zeros(schemaNum,timeSteps);
o_GPe = zeros(schemaNum,timeSteps);
o_GPi = zeros(schemaNum,timeSteps);
o_SMA = zeros(schemaNum,timeSteps);
o_THAL = zeros(schemaNum,timeSteps);

thalExc = zeros(schemaNum,timeSteps);

%lambda = 0.5;
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

Wsch = zeros(schemaNum,schemaNum);
Wsch = Wsch - diag(0.2*ones(1,size(Wsch,2))); % Mild Self-excitation/Self-inhibition
%Wsch = 0.5*ones(schemaNum,schemaNum);

% All the other weights are null

%% Initialise Environment Matrix (ENV)
% For every schema there is an environmental trigger
% Unlike the weight matrix, this matrix has ENV(schema, time unit)

o_ENV = zeros(schemaNum, timeSteps);

%% Initialise Prefrontal Cortex Matrix (PFC)

o_PFC = zeros(schemaNum, timeSteps);

