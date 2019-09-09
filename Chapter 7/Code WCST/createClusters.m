% Clustering data in groupsNum groups
% Returns groupsNum cells with three columns, one for
% each outcome variable (TE,PE,SL3)

function WCSTclusters_stats = createClusters(indivStats, groupsNum)

% indivStats_matrix format: CC, WTE, PE, SL3
indivStats_matrix = [[indivStats.TE]', [indivStats.PE]', [indivStats.SL3]', [indivStats.Age]'];

%% Find the centroid wih k-means alg  orithm, initial conditions set
[idxNP,~,~] = kmeans(double(indivStats_matrix(:,[1:3])),groupsNum,'Start','uniform','distance','sqeuclidean','OnlinePhase','on','Replicates',100000);

%% Organise the indexed dataset in k-cell array with n x 3 matrices
WCSTclusters_stats = {};

% Cell values can be accessed this way
% that can be accessed this way: WCSTclusters_stats{1}.TE

for cc = 1:max(idxNP)
    
    WCSTclusters_stats{cc}.TE = double(indivStats_matrix(idxNP == cc,1));
    WCSTclusters_stats{cc}.PE = double(indivStats_matrix(idxNP == cc,2));
    WCSTclusters_stats{cc}.SL3 = double(indivStats_matrix(idxNP == cc,3));
    WCSTclusters_stats{cc}.Age = double(indivStats_matrix(idxNP == cc,4));

end

end

