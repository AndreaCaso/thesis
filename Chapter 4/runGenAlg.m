%% Genetic Algorithm
clear; clc;

%Input vector = ...
%... [w_ext w_ctx bias_pfc beta_ctx noise_mod];

%Output vector = ...
%... [TE PR PE SL CC NPE]

load('NPYoungData.mat');
load('genomes.mat');

YoungNPdata = [TEYoungNP' PRYoungNP' PEYoungNP' SLYoungNP' catNumYoungNP' NPEYoungNP'];
YoungNPmean = [mean(TEYoungNP) mean(PRYoungNP) mean(PEYoungNP) mean(SLYoungNP) mean(catNumYoungNP) mean(NPEYoungNP)];
YoungNPstd = [std(TEYoungNP) std(PRYoungNP) std(PEYoungNP) std(SLYoungNP) std(catNumYoungNP) std(NPEYoungNP)];

lastIndex = length(genome1);
%lastIndex = 0; % overwrite
fitHist = nan(1,200);

initialiseRAND; %produces initialising random vectors

fprintf('Running Genetic Algorithm\n');  

for c1 = 1:50
%% initialiseRAND sets simulation parameters

fprintf('Run %1.0f',c1);
%% Simulation WCST

for c2 = 1:48
    
initialise; %initialise all variables

%%% apply different independent variable to the simulation

alpha_sma = alpha_sma_R(c1);
alpha_pfc = alpha_sma; 

alpha_stn = alpha_stn_R(c1);
alpha_gpi = alpha_stn;
alpha_gpe = alpha_stn;
alpha_thal = alpha_stn;

alpha_str = alpha_str_R(c1);
alpha_str_pfc = alpha_str*(ones(1,3));
alpha_str_sma = alpha_str*(ones(1,4));

extBase = extBase_R(c1);
parBase = parBase_R(c1);

%%%

runWCST;
fprintf('.');
   
%% Registering dependent vars values... [TE PR PE SL CC NPE]
genome1(c1 + lastIndex).dependent(c2,:) = [TEerrors sum(PRerrors) sum(PEerrors) sum(SL5errors) catNum sum(NPEerrors)];

end
%% Registering independent vars value
genome1(c1 + lastIndex).alpha_str = alpha_str_pfc;
genome1(c1 + lastIndex).alpha_ctx = alpha_sma;
genome1(c1 + lastIndex).alpha_bg = alpha_stn;
genome1(c1 + lastIndex).alpha_str = alpha_str;
    
genome1(c1 + lastIndex).extBase = extBase;
genome1(c1 + lastIndex).parBase = parBase;
    
%% Calculate Fitness with t scores (welch) (inverse)
pooled_var = ( (size(YoungNPdata,1) - 1)*var(YoungNPdata) + (size(genome1(c1 + lastIndex).dependent,1) - 1)*var(genome1(c1 + lastIndex).dependent) ) / (size(YoungNPdata,1) + size(genome1(c1 + lastIndex).dependent,1) - 2);
t_scores = (mean(genome1(c1 + lastIndex).dependent) - mean(YoungNPdata))./sqrt(pooled_var);

genome1(c1 + lastIndex).invfitnessT = abs(t_scores); % vector with t statistics
genome1(c1 + lastIndex).invfitnessTN = mean(genome1(c1 + lastIndex).invfitnessT); %norm of d statistics

%% Calculate Fitness with Glass delta scores (non pooled) (inverse)
delta_value = ( mean(genome1(c1 + lastIndex).dependent) - mean(YoungNPdata) ) ./ ( std(YoungNPdata) ); 

genome1(c1 + lastIndex).invfitnessDelta = abs(delta_value);
%genome1(c1 + lastIndex).fitnessDeltaN = mean(genome1(c1 + lastIndex).fitnessDelta);

%% Max Glass delta index

genome1(c1 + lastIndex).maxDelta = max(genome1(c1 + lastIndex).invfitnessDelta);

%% Total fitness 
% calculated with the inverse of the product between std and mean of the
% delta score (non pooled) vector of the fitness vector (see above)
% The higher the fitness, the better the set of parameters

genome1(c1 + lastIndex).totalFit = (1/(mean(genome1(c1 + lastIndex).invfitnessT)*std(genome1(c1 + lastIndex).invfitnessT)))^(1/2);

%% Completion

save('genomes.mat','genome1','-append');
fprintf('completed and saved\n');  
try 

if mod(c1,2) == 0  % Every two trials print the best fit data
    
    for ii = 1:length(genome1)
     fitHist(ii) = genome1(ii).fitnessTN; %memorise fitness values in a vector
    end 
    
    indexMin = find(fitHist == min(fitHist)); % finds the index of the minimum fitness value
    indexMin = indexMin(1); %make sure it's a scalar
    bestDep = round(mean(genome1(indexMin).dependent),2);
    
    fprintf('Best dependent set so far: %s\n', strjoin(cellstr(num2str(bestDep(:))),', '));
    fprintf('Maximum difference in the best set %1.2f\n', genome1(indexMin).maxDelta);
    
end
catch
end
end

fprintf('Job completed and saved\n');  
%save('genomes.mat','genome1','-append');
beep;




