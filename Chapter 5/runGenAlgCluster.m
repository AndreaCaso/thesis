%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Genetic Algorithm for Clusters
% Runs the genetic algorithm for different clusters separately
% 
% Usage example:
% genome1 = runGenAlgCluster(YoungNPdataSET{1},1,200);
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varname = runGenAlgCluster(dataset_cell,group_num,iterations)
% Load GenAlgClusterData to run the function  
% lastIndex = length(varname);
load('GenAlgClusterData.mat');
lastIndex = 0;
 
fitHist = nan(1,200);
%initialiseRAND; %produces initialising random vectors

fprintf('Running Genetic Algorithm\n');  

for c1 = 1:iterations
%% initialiseRAND sets simulation parameters

fprintf('Run %1.0f',c1);
%% Simulation WCST

for c2 = 1:length(dataset_cell) %number of simulations

initialise; %initialise all variables

%%% apply different independent variable to the simulation
%%% (overwrite)

beta_ctx = unifrnd(beta_ctx_base(group_num)-0.1,beta_ctx_base(group_num)+0.1);
beta_sma = beta_ctx*(ones(1,4));
beta_pfc = beta_ctx*(ones(1,3));

alpha_stn = unifrnd(alpha_bg_base(group_num)-1,alpha_bg_base(group_num)+1);
alpha_gpi = alpha_stn;
alpha_gpe = alpha_stn;
alpha_thal = alpha_stn;

beta_thal = unifrnd(beta_thal_base(group_num)-0.1,beta_thal_base(group_num)+0.1);

beta_str = unifrnd(beta_str_base(group_num)-0.1,beta_str_base(group_num)+0.1);
beta_str_sma = beta_str*(ones(1,4));
beta_str_pfc = beta_str*(ones(1,3));

extBase = unifrnd(extBase_base(group_num)-0.1,extBase_base(group_num)+0.1);
parBase = unifrnd(parBase_base(group_num)-0.1,parBase_base(group_num)+0.1); 

biasValue = unifrnd(biasValue_base(group_num)-0.1,biasValue_base(group_num)+0.1);

wPar = unifrnd(wPar_base(group_num)-0.1,wPar_base(group_num)+0.1);
%%%%%%%%%%%%%%%%%%%%

runWCST;
fprintf('.');
   
%% Registering dependent vars values... [TE PE SL]

varname(c1 + lastIndex).dependent(c2,:) = [TEerrors sum(PEerrors) sum(SL5errors)];

end
%% Registering independent vars value
varname(c1 + lastIndex).group = group_num;

varname(c1 + lastIndex).beta_ctx = beta_sma;
varname(c1 + lastIndex).alpha_bg = alpha_stn;

varname(c1 + lastIndex).beta_thal = beta_thal;
varname(c1 + lastIndex).beta_str = beta_str;

varname(c1 + lastIndex).extBase = extBase;
varname(c1 + lastIndex).parBase = parBase;

varname(c1 + lastIndex).biasValue = biasValue;
varname(c1 + lastIndex).wPar = wPar;


%% Calculate Fitness with z scores (variance is in the model) - fitness has to be minimum here
z_scores = (mean(varname(c1 + lastIndex).dependent) - mean(dataset_cell))./std(dataset_cell);

z_scores(isnan(z_scores)) = 0;

varname(c1 + lastIndex).invfitnessZ = abs(z_scores); % vector with t statistics
varname(c1 + lastIndex).invfitnessZN = mean(varname(c1 + lastIndex).invfitnessZ); %norm of d statistics

%% Max Z score

varname(c1 + lastIndex).maxZ = max(abs(z_scores));

%% Calculate Fitness with t scores (variance is pooled) - fitness has to be minimum here
[~,~,~,stats] = ttest2(dataset_cell,varname(c1 + lastIndex).dependent);
t_scores = stats.tstat;

varname(c1 + lastIndex).invfitnessT = abs(t_scores); % vector with t statistics
varname(c1 + lastIndex).invfitnessTN = mean(varname(c1 + lastIndex).invfitnessT); %norm of d statistics
%% Calculate Fitness with Glass delta scores (non pooled) (inverse)
delta_value = ( mean(varname(c1 + lastIndex).dependent) - mean(dataset_cell) ) ./ ( std(dataset_cell) ); 

varname(c1 + lastIndex).invfitnessDelta = abs(delta_value);

%% Max Glass delta index

varname(c1 + lastIndex).maxDelta = max(varname(c1 + lastIndex).invfitnessDelta);

%% Max T score

varname(c1 + lastIndex).maxT = max(abs(t_scores));

%% Total fitness 
% calculated with the inverse of the product between std and mean of the
% delta score (non pooled) vector of the fitness vector (see above)
% The higher the fitness, the better the set of parameters

varname(c1 + lastIndex).totalFit = (1/(mean(varname(c1 + lastIndex).invfitnessT)*std(varname(c1 + lastIndex).invfitnessT)))^(1/2);

%% Completion

%save('GenAlgClusterData.mat',varname,'-append');
fprintf('completed\n');  

% Print the best fit data
try
    for ii = 1:length(varname)
       fitHist(ii) = varname(ii).totalFit; %memorise fitness values in a vector
    end
    
    indexMax = find(fitHist == max(fitHist)); %finds the index of the maximum fitness value
    indexMax = indexMax(1); %make sure it's a scalar
    bestDep = round(mean(varname(indexMax).dependent),2);
    
    fprintf('Best dependent set so far: %s\n', strjoin(cellstr(num2str(bestDep(:))),', '));
    fprintf('Maximum difference in the best set (T score) %1.2f\n', varname(indexMax).maxT);
catch
    fprintf('Cannot print best set\n');
end

%fprintf('Job completed and saved\n');  
%save('GenAlgClusterData.mat',varname,'-append');

end



