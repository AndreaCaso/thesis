%% Clustering data in 5 groups

%% Remove 2 outliers from the Data set (NP data)
YoungNPdata3 = YoungNPdata(:,[1 3 4]); % YoungSIMdata3 and YoungNPdata3 format [TE PE SL]
YoungSIMdata3 = YoungSIMdata(:,[1 3 4]);
YoungNPdata3(find(ismember(YoungNPdata3,[15 7 2],'rows')),:) = [];
YoungNPdata3(find(ismember(YoungNPdata3,[32 24 1],'rows')),:) = [];

%% Find the centroid wih k-means algorithm, initial conditions set

[idxSIM,centrSIM,sumdSIM] = kmeans(YoungSIMdata3,[],'start',[10 7 0;18 9 0; 27 17 0; 16 10 1; 20 11 0],'distance','cityblock');
[idxNP,centrNP,sumdNP] = kmeans(YoungNPdata3,[],'start',[10 7 0;18 9 0; 27 17 0; 16 10 1; 20 11 0],'distance','cityblock');

%% Organise the indexed dataset in k-cell array with n x 3 matrices
YoungNPdataSET = {};
for cc = 1:max(idxNP)
    
    YoungNPdataSET{cc} = YoungNPdata3(idxNP == cc,:);
    
end

YoungSIMdataSET = {};
for cc = 1:max(idxSIM)
    
    YoungSIMdataSET{cc} = YoungSIMdata3(idxSIM == cc,:);
    
end

