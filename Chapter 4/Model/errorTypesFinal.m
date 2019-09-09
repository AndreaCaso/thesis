%% Turn all the empty features in the trial in 'x'
for ii = 1:length(featureTrial)
    if isequal(featureTrial(ii), {[]})    
       featureTrial(ii) = strcat(featureTrial(ii) , 'x');
    end
end

%% Learning to learn
% it is calculated at the end of the performance
% (Heaton)
if catNum >= 4
    
    catNumTrial = catNumTrial(1:64);
    catPES = zeros(1,max(catNumTrial));

    for cc = 1:max(catNumTrial)
        % category percentage error score
        catPES(cc) = sum(correctTrial(find(catNumTrial == cc)))/length((correctTrial(find(catNumTrial == cc))));
    end
    diffCatScore = zeros(1,length(catPES) - 1);
    for cc = 1:length(catPES) - 1
        diffCatScore(cc) = catPES(cc) - catPES(cc+1);
    end
    LTL = mean(diffCatScore);
end

%% TFC - Trials to first category
% (Heaton)

TFC = find(catNumTrial==1);
TFC = TFC(end);

%% SL - Set loss Heaton (after 5)
successiveCounter = 0;

for ii = 1:64
    
    if successiveCounter >= 10;
         successiveCounter = 0;
    end
    
    if correctTrial(ii) == 1
         successiveCounter = successiveCounter + 1;
    elseif correctTrial(ii) == 0
         if successiveCounter >= 5 
            if isUnambigous(featureTrial,ii,successiveCounter)   %unumbigous response
                SL5errors(ii) = 1;
            end
         end
    successiveCounter = 0;
    end
    
end

%% Classic perseverative errors (PE) Heaton
 
    persCrit = ''; % perseverative criterion (n = number c = colour f = form)
    sortingCrit = '';
    persevere_to = cell(1,64);  cc = 1; % for the second exception, last three wrong sorting criteria
    
    for card = 1:64
        
        % Encoding the partecipant sorting criteria by letter 
        % We have featureTrial vector (1,64)
                     
        % Count PR and PE when at least one category has been completed
            
         if catNumTrial(card) > 1
            % set pers. criterion to the previous category
            persCrit = category(catNumTrial(card) - 1);
            % compare perseverative and sorting criterion
            if ~isempty(strfind(char(featureTrial(card)),persCrit));
                PRerrors(card) = 1;
                if correctTrial(card) == 0;
                   PEerrors(card) = 1;
                end
            end   
         end
      
        % Count PR and PE when one category hasn't been completed
        % That is, current category is still 1 (dataYoung(:,4))
        % The subject can perseverate 
        % despite being still on the first category
        
        if catNumTrial(card) == 1 
     
          % Compare perseverative and sorting criterion at each cycle
          
           if ~isempty(strfind(sortingCrit,persCrit));
                %if isUnambigous(featureTrial,card,1)
                   PRerrors(card) = 1;
                %end
                if correctTrial(card) == 0;
                   PEerrors(card) = 1;
                end
           end
           
           % Criteria for selecting pers. response (1) 
           % incorrect unambigous response            
            if correctTrial(card) == 0
                
               % Encode pers. criterion by letter
                  if isequal(char(featureTrial(card)) , 'n') 
                    persCrit = 'n'; 
                    
                  elseif isequal(char(featureTrial(card)) , 'c')
                    persCrit = 'c'; 
                    
                  elseif isequal(char(featureTrial(card)) , 's')
                    persCrit = 's'; 
                        
                  end
                  
            end
            
            % Criteria for selecting pers. response (2) 
                  
            persevere_to{cc} = featureTrial(card); 
            cc = cc + 1;
            
            if card > 3  
                
                if isUnambigous(featureTrial,card,3) &&...
                isequal(correctTrial(card-2:card),[0 0 0])
                    
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

%% TE - Total Error  
% (Heaton)

TEerrors = 64 - sum(correctTrial);

%% NPE - Non pers. responses
NPEerrors = TEerrors - sum(PEerrors);



