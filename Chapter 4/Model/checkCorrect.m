%% Check if the card is correct

SMAs = [o_SMA(1,tt) o_SMA(2,tt) o_SMA(3,tt) o_SMA(4,tt)];
SMAdec = SMAdec + SMAs*decCounter;
decCounterTot(trial) = decCounter;

if any(SMAdec > 3e4) && any(SMAs > 0.5)  % changed 06dec2016
    
    if ~any(SMAs > 0.5)
        disp(x);
    end
    %disp(trial); disp(SMAdec); disp(tt);
    decCounter = 0; % Reset Counter
    SMAdec = 0; % Reset Counter(2)
    indexSMA = find(SMAs == max(SMAs));
    indexSMA = indexSMA(1); % in case it's a vector
    
    chosenCard(trial) = indexSMA;
    
    if strcmp(char(cardsDeck(trial).colour),char(cardsTable(indexSMA).colour));
            featureTrial(trial) = strcat(featureTrial(trial),'c');
            
            %fprintf('Colours in the target and stimulus match. \n');
            %fprintf(fileID, '[TIME = %4.0d] Colours in the target and stimulus match. %1d correct\n',tt, sum(correctTrial));
   
    end
    
    if cardsDeck(trial).itemnum == cardsTable(indexSMA).itemnum;
           featureTrial(trial) = strcat(featureTrial(trial),'n');
           
           %fprintf('Numbers in the target and stimulus match. \n');
           %fprintf(fileID, '[TIME = %4.0d] Numbers in the target and stimulus match. %1d correct \n', tt, sum(correctTrial));
    end
       
    if strcmp(char(cardsDeck(trial).shape),char(cardsTable(indexSMA).shape));
            featureTrial(trial) = strcat(featureTrial(trial),'s');
            
            %fprintf('Shapes in the target and stimulus match. \n');
            %fprintf(fileID, '[TIME = %4.0d] Shapes in the target and stimulus match. %1d correct \n', tt, sum(correctTrial));
            
    end
    
    if isequal(featureTrial(trial), {[]})
        
        featureTrial(trial) = strcat(featureTrial(trial),'x');
        %fprintf('No feature matches. \n');
        %fprintf(fileID, '[TIME = %4.0d] No feature matches. %1d correct \n', tt, sum(correctTrial));
          
    end
    
    %% Now check if the answer is correct  
   
   
    commonFeature = strfind(featureTrial(trial),category(catNum));

    if ~isempty(commonFeature{1})
        
        correctTrial(trial) = 1;
        correctCounter = correctCounter + 1;
        %fprintf('Correct response. Total correct responses %1.0f\n', sum(correctTrial));
        %fprintf(fileID, '[TIME = %4.0d] Correct response. Total correct responses %1.0f \n', tt, sum(correctTrial));
           
    else
        
        correctTrial(trial) = 0;   %redundant
       
        correctCounter = 0; %reset the counter
        %fprintf('Incorrect response. \n');
        %fprintf(fileID, '[TIME = %4.0d] Incorrect response. Total correct responses %1.0f \n', tt, sum(correctTrial));
        
    end


%% Bias the pFC in order to maximise reward (correct answers)

biasPFC;


%% Change the rule if there are too many correct answers in a row

if catNum < 6 && trial >= 10 
    if correctCounter == 10
         
         correctCounter = 0; % reset counter in a row 
         catNum = catNum + 1; % one category ticked off
         
         %fprintf(fileID, 'Change of rule: Category %1.0f\n', catNum);  
         %fprintf('Change of rule: Category %1.0f\n', catNum);
      
    end
end

end

