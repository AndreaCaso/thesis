%% Turn all the empty features in the counter.trial_num in 'x'
for ii = 1:length(counter.feature_trial)
    if isequal(counter.feature_trial(ii), {[]})    
       counter.feature_trial(ii) = strcat(counter.feature_trial(ii) , 'x');
    end
end

%% Learning to learn
% it is calculated at the end of the performances
% (Heaton)
    
    performances.CCTrial = performances.CCTrial(1:lstim);
    catPES = zeros(1,max(performances.CCTrial));

    for cc = 1:max(performances.CCTrial)
        % category percentage error score
        catPES(cc) = sum(counter.correct_counter_vector(find(performances.CCTrial == cc)))/length((counter.correct_counter_vector(find(performances.CCTrial == cc))));
    end
    diffCatScore = zeros(1,length(catPES) - 1);
    for cc = 1:length(catPES) - 1
        diffCatScore(cc) = catPES(cc) - catPES(cc+1);
    end
    performances.LTL = mean(diffCatScore);


%% performances.TFC - Trials to first category
% (Heaton)

performances.TFC = find(performances.CCTrial==1);
%performances.TFC = performances.TFC(end);
%% General RT - response time
performances.RT = counter.trial_num_time_tot;
performances.normalRT = (performances.RT - mean(performances.RT))/std(performances.RT);

%% RT AFTER correct responses
% index trials after the correct ones
idx_corr =  find(counter.correct_counter_vector == 1) + 1; 
idx_corr = idx_corr(idx_corr < lstim);
performances.RTcorr = performances.RT(idx_corr);

clear idx_corr;

% index trials after the correct ones
idx_incorr =  find(counter.correct_counter_vector == 0) + 1; 
idx_incorr = idx_incorr(idx_incorr < lstim);
performances.RTincorr = performances.RT(idx_incorr);

clear idx_incorr;
%% SL - Set loss Heaton (after 5)
successiveCounter = 0;

for ii = 1:lstim
    
    if successiveCounter >= counter.criterion
         successiveCounter = 0;
    end
    
    if counter.correct_counter_vector(ii) == 1
         successiveCounter = successiveCounter + 1;
    elseif counter.correct_counter_vector(ii) == 0
         if successiveCounter >= 5 
            if isUnambigous(counter.feature_trial,ii,successiveCounter)   %unumbigous response
                performances.SL5(ii) = 1;
                if ii<lstim
                  performances.RT_SL5(ii) = counter.trial_num_time_tot(ii+1); %successive counter.trial_num!
                end
            end
         end
    successiveCounter = 0;
    end
    
end

%% SL - Set loss Stuss (after 3)
successiveCounter = 0;

for ii = 1:lstim
    
    if successiveCounter >= counter.criterion
         successiveCounter = 0;
    end
    
    if counter.correct_counter_vector(ii) == 1
         successiveCounter = successiveCounter + 1;
    elseif counter.correct_counter_vector(ii) == 0
         if successiveCounter >= 3 
            if isUnambigous(counter.feature_trial,ii,successiveCounter)   %unumbigous response
                performances.SL3(ii) = 1;
                if ii<lstim
                 performances.RT_SL3(ii) = counter.trial_num_time_tot(ii+1);
                end
            end
         end
    successiveCounter = 0;
    end
    
end

%% Classic perseverative errors (PE) Heaton
 
    persCrit = ''; % perseverative criterion (n = number c = colour f = form)
    sortingCrit = '';
    persevere_to = cell(1,lstim);  cc = 1; % for the second exception, last three wrong sorting criteria
    
for card = 1:lstim
        
        % Encoding the partecipant sorting criteria by letter 
        % We have counter.feature_trial vector (1,lstim)
                     
        % Count PR and PE when at least one category has been completed
            
         if performances.CCTrial(card) > 1
            % set pers. criterion to the previous category
            persCrit = category(performances.CCTrial(card) - 1);
            % compare perseverative and sorting criterion
            if ~isempty(strfind(char(counter.feature_trial(card)),persCrit));
                performances.PR(card) = 1;
                if counter.correct_counter_vector(card) == 0
                   performances.PE(card) = 1;
                   if card<lstim
                    performances.RT_PE(card) = counter.trial_num_time_tot(card+1);
                   end
                end
            end   
         end
      
        % Count PR and PE when one category hasn't been completed
        % That is, current category is still 1 (dataYoung(:,4))
        % The subject can perseverate 
        % despite being still on the first category
        
        if performances.CCTrial(card) == 1 
     
          % Compare perseverative and sorting criterion at each cycle
          
           if ~isempty(strfind(sortingCrit,persCrit));
                %if isUnambigous(counter.feature_trial,card,1)
                   performances.PR(card) = 1;
                %end
                if counter.correct_counter_vector(card) == 0;
                   performances.PE(card) = 1;
                   if card<lstim
                    performances.RT_PE(card) = counter.trial_num_time_tot(card+1);
                   end
                end
           end
           
           % Criteria for selecting pers. response (1) 
           % incorrect unambigous response            
            if counter.correct_counter_vector(card) == 0
                
               % Encode pers. criterion by letter
                  if isequal(char(counter.feature_trial(card)) , 'n') 
                    persCrit = 'n'; 
                    
                  elseif isequal(char(counter.feature_trial(card)) , 'c')
                    persCrit = 'c'; 
                    
                  elseif isequal(char(counter.feature_trial(card)) , 's')
                    persCrit = 's'; 
                        
                  end
                  
            end
            
            % Criteria for selecting pers. response (2) 
                  
            persevere_to{cc} = counter.feature_trial(card); 
            cc = cc + 1;
            
            if card > 3  
                
                if isUnambigous(counter.feature_trial,card,3) &&...
                isequal(counter.correct_counter_vector(card-2:card),[0 0 0])
                    
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

performances.TE = ~logical(counter.correct_counter_vector);

%% NPE - Non pers. responses
performances.NPE = (performances.TE & ~logical(performances.PE));



