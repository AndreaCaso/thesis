%% Generate data from Cooper ()
% WCST with young adults 
dbstop if error

partecipant = {'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21' '22' '23' '24' '25' '26' '27' '28' '29' '30' '31' '32' '33' '34' '35' '36' '37' '38' '39' '40' '41' '42' '43' '44' '45' '46' '47' '48'};
TEYoungNP = zeros(1,length(partecipant));
PEYoungNP = zeros(1,length(partecipant));
NPEYoungNP = zeros(1,length(partecipant));
PRYoungNP = zeros(1,length(partecipant));
catNumYoungNP = zeros(1,length(partecipant));
SLYoungNP = zeros(1,length(partecipant)); % Set Loss Error is for 5 categories!

for c1 = 1:length(partecipant)
    
    %% Load partecipant c1 txt file
    % Don't forget to add the path
    
    % fileFolder = 'C:\Users\acosa\Dropbox\PhD Andrea Caso 12801678\WCST - YoungControls\';
    % fileID = fopen([fileFolder, 'wcst_10',char(partecipant(c1)),'_0.txt'],'r'); 
    fileID = fopen(['wcst_10',char(partecipant(c1)),'_0.txt'],'r'); 
    
    %% Produces matrix with Neuropsychological Results from WSCT Cooper
    dataYoung = textscan(fileID,'[%d,%d,%d] %d %d %d');
    dataYoung = cell2mat(dataYoung); 
    
    %% Calculate Total Errors
    TEYoungNP(c1) = sum(dataYoung(:,6) == 0);
    
    %% Calculate Number of Categories Completed
    
    catNumYoungNP(c1) = max(dataYoung(:,4)) - 1;
    
    %% Calculate Set Loss (after 5) (Heaton)
    successiveCounter = 0;
    
    for c2 = 1:64
     
     if successiveCounter >= 10;
         successiveCounter = 0;
     end 
     
     if dataYoung(c2,6) == 1
        successiveCounter = successiveCounter + 1 ;
     elseif dataYoung(c2,6) == 0
        if successiveCounter >= 5 
            if isUn(dataYoung(c2-successiveCounter:c2,1:3))   %unumbigous response
                SLYoungNP(c1) = SLYoungNP(c1) + 1;
            end
        end
        successiveCounter = 0; % Reset the successive correct matches
     end
     
    end
    
    %% Calculate Perseverative Response and Error(Heaton)
    persCrit = ''; % perseverative criterion (n = number c = colour f = form)
    sortingCrit = '';
    categ = ['c','f','n','c','f','n'];
    persevere_to = cell(1,64);  cc = 1; % for the second exception, last three wrong sorting criteria
    
    for c2 = 1:64
        
        % Encoding the partecipant sorting criteria by letter 
        
           if isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) ,[1])
               sortingCrit = 'n'; 
           elseif isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [2])
               sortingCrit = 'c';
           elseif isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [3])
               sortingCrit = 'f';
           elseif isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [1 2 3])
               sortingCrit = 'ncf';
           elseif isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [1 2])
               sortingCrit = 'nc';
           elseif isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [2 3])
               sortingCrit = 'cf';
           elseif isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [1 3])
               sortingCrit = 'nf';
           else
               sortingCrit = 'x';
           end
           
         % Count PR and PE when at least one category has been completed
            
         if dataYoung(c2,4) > 1 
            % set pers. criterion to the previous category
            persCrit = categ(dataYoung(c2,4) - 1);
            % compare perseverative and sorting criterion
            if ~isempty(strfind(sortingCrit,persCrit));
                PRYoungNP(c1) = PRYoungNP(c1) + 1;
                if dataYoung(c2,6) == 0;
                    PEYoungNP(c1) = PEYoungNP(c1) + 1;
                end
            end   
         end
        
        % Count PR and PE when one category hasn't been completed
        % That is, current category is still 1 (dataYoung(:,4))
        % The subject can perseverate 
        % despite being still on the first category
        
        if dataYoung(c2,4) == 1 
         
          % Compare perseverative and sorting criterion at each cycle
          
           if ~isempty(strfind(sortingCrit,persCrit));
                PRYoungNP(c1) = PRYoungNP(c1) + 1;
                if dataYoung(c2,6) == 0;
                  PEYoungNP(c1) = PEYoungNP(c1) + 1;
                  %PEY18 = PEYoungNP(18);
                end
           end
           
           % Criteria for selecting pers. response (1) 
           % incorrect unambigous response            
            if dataYoung(c2,6) == 0
             
               % Encode pers. criterion by letter
                  if isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [1])
                    persCrit = 'n'; 
                    
                  elseif isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [2])
                    persCrit = 'c'; 
                    
                  elseif isequal(find(dataYoung(c2,1:3) == dataYoung(c2,5)) , [3])
                    persCrit = 'f'; 
                        
                  end
                  
            end
            
            % Criteria for selecting pers. response (2) 
                  
            persevere_to{cc} = sortingCrit; 
            cc = cc + 1;
            
            if c2 >= 3  
                
                if isUn(dataYoung(c2-2:c2,(1:3))) && isequal(dataYoung(c2-2:c2,6), [0 0 0]') % there is at least one unumbigous
                    
                    % checks if the last three non-empty cells in
                    % persevere_to contain the letter
                    
                    if comparePersev(persevere_to,'n') >= 3
                        persCrit = 'n';                                
                    elseif comparePersev(persevere_to,'c') >= 3
                        persCrit = 'c';                                
                    elseif comparePersev(persevere_to,'f') >= 3
                        persCrit = 'f';       
        
                    end     
                    
                end
                   
            end
          
        end 
        
        
        end
        
    
    %% Calculate non-perseverative error (Heaton)
    
    NPEYoungNP = TEYoungNP - PEYoungNP;
    
    %% Close partecipant c1 files
    fclose(fileID);
    
end

clear c1; clear c2; clear cc; clear categ; clear fileID;
clear persCrit; clear sortingCrit; clear successiveCounter;
clear partecipant; clear persevere_to;

YoungNPdata = [TEYoungNP' PRYoungNP' PEYoungNP' SLYoungNP' catNumYoungNP' NPEYoungNP'];

%% Save results
save('NPYoungData.mat','YoungNPdata','catNumYoungNP','PRYoungNP','PEYoungNP','TEYoungNP','NPEYoungNP','SLYoungNP','-append');
