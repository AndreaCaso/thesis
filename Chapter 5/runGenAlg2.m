%% Genetic Algorithm - 2nd iteration
clear; clc;

%Output vector dependent variable
%... [TE PR PE SL CC NPE]

load('NPYoungData.mat');
load('genomes.mat');

YoungNPdata = [TEYoungNP' PRYoungNP' PEYoungNP' SLYoungNP' catNumYoungNP' NPEYoungNP'];
YoungNPmean = [mean(TEYoungNP) mean(PRYoungNP) mean(PEYoungNP) mean(SLYoungNP) mean(catNumYoungNP) mean(NPEYoungNP)];
YoungNPstd = [std(TEYoungNP) std(PRYoungNP) std(PEYoungNP) std(SLYoungNP) std(catNumYoungNP) std(NPEYoungNP)];

lastIndex = length(genome2);
%lastIndex = 0; % overwrite
fitHist = nan(1,200);

initialiseRAND2; %produces initialising random vectors

fprintf('Running Genetic Algorithm\n');  

for c1 = 1:50

fprintf('Run %1.0f',c1);
%% Simulation WCST

for c2 = 1:48
    
initialise; %initialise all variables

%%% apply (overwrite) different independent variable to the simulation

beta_thal = beta_thal_R(c1);
biasValue = biasValue_R(c1);
wExt = wExt_R(c1);
wPar = wPar_R(c1);

%%%

runWCST;
fprintf('.');
   
%% Registering dependent vars values... [TE PR PE SL CC NPE]
genome2(c1 + lastIndex).dependent(c2,:) = [TEerrors sum(PRerrors) sum(PEerrors) sum(SL5errors) catNum sum(NPEerrors)];
save('genomes.mat','genome2','-append');
end
%% Registering independent vars value
genome2(c1 + lastIndex).beta_thal = beta_thal;
genome2(c1 + lastIndex).biasValue = biasValue;

genome2(c1 + lastIndex).wExt = wExt;
genome2(c1 + lastIndex).wPar = wPar;
    
%% Calculate Fitness with t scores (welch) (inverse)
pooled_var = ( (size(YoungNPdata,1) - 1)*var(YoungNPdata) + (size(genome2(c1 + lastIndex).dependent,1) - 1)*var(genome2(c1 + lastIndex).dependent) ) / (size(YoungNPdata,1) + size(genome2(c1 + lastIndex).dependent,1) - 2);
t_scores = (mean(genome2(c1 + lastIndex).dependent) - mean(YoungNPdata))./sqrt(pooled_var);

genome2(c1 + lastIndex).invfitnessT = abs(t_scores); % vector with t statistics
genome2(c1 + lastIndex).invfitnessTN = mean(genome2(c1 + lastIndex).invfitnessT); %norm of d statistics

%% Calculate Fitness with Glass delta scores (non pooled) (inverse)
delta_value = ( mean(genome2(c1 + lastIndex).dependent) - mean(YoungNPdata) ) ./ ( std(YoungNPdata) ); 

genome2(c1 + lastIndex).invfitnessDelta = abs(delta_value);
%genome2(c1 + lastIndex).fitnessDeltaN = mean(genome2(c1 + lastIndex).fitnessDelta);

%% Max Glass delta index

genome2(c1 + lastIndex).maxDelta = max(genome2(c1 + lastIndex).invfitnessDelta);

%% Total fitness 
% calculated with the inverse of the product between std and mean of the
% delta score (non pooled) vector of the fitness vector (see above)
% The higher the fitness, the better the set of parameters

genome2(c1 + lastIndex).totalFit = (1/(mean(genome2(c1 + lastIndex).invfitnessDelta)*std(genome2(c1 + lastIndex).invfitnessDelta)))^(1/2);

%% Completion

save('genomes.mat','genome2','-append');
fprintf('completed and saved\n');  
try 

if mod(c1,2) == 0  % Every two trials print the best fit data
    
    for ii = 1:length(genome2)
     fitHist(ii) = genome2(ii).fitnessTN; %memorise fitness values in a vector
    end 
    
    indexMin = find(fitHist == min(fitHist)); % finds the index of the minimum fitness value
    indexMin = indexMin(1); %make sure it's a scalar
    bestDep = round(mean(genome2(indexMin).dependent),2);
    
    fprintf('Best dependent set so far: %s\n', strjoin(cellstr(num2str(bestDep(:))),', '));
    fprintf('Maximum difference in the best set %1.2f\n', genome2(indexMin).maxDelta);
    
end
catch
end
end

fprintf('Job completed and saved\n');  
%save('genomes.mat','genome2','-append');
beep;




