% Bias PFC after receiving reward 
% to increase the future reward
% positiveBias = +bias;
% negativeBias = -bias;

%% Colour, Number, Shape
bias_PFC = biasValue + pfcNoise*randn;

if correctTrial(trial) == 1
     
    if strcmp(char(cardsDeck(trial).colour),char(cardsTable(indexSMA).colour))
        %o_EXT_PFC(1,tt:timeSteps) = sigmf(o_EXT_PFC(1,tt) + pfcRate + randn*pfcNoise,[5 0.5]);  
        o_EXT_PFC(1,tt:timeSteps) = satlin(o_EXT_PFC(1,tt) + bias_PFC);
        
        %fprintf('Excite COLOUR schema \n');
        %fprintf(fileID, '[TIME = %4.0f] Excited COLOUR Schema \n',tt);
    
    end
    
    if cardsDeck(trial).itemnum == cardsTable(indexSMA).itemnum  
        %o_EXT_PFC(2,tt:timeSteps) = sigmf(o_EXT_PFC(2,tt) + pfcRate + randn*pfcNoise,[5 0.5]); 
        o_EXT_PFC(2,tt:timeSteps) = satlin(o_EXT_PFC(2,tt) + bias_PFC);
        
        %fprintf('Excite NUMBER schema \n');
        %fprintf(fileID, '[TIME = %4.0f] Excited NUMBER Schema \n',tt);
    end
    
    if strcmp(char(cardsDeck(trial).shape),char(cardsTable(indexSMA).shape))
        %o_EXT_PFC(3,tt:timeSteps) = sigmf(o_EXT_PFC(3,tt) + pfcRate + randn*pfcNoise,[5 0.5]);
        o_EXT_PFC(3,tt:timeSteps) = satlin(o_EXT_PFC(3,tt) + bias_PFC);
       
        %fprintf('Excite SHAPE schema \n');
        %fprintf(fileID, '[TIME = %4.0f] Excited SHAPE Schema \n',tt);
    end
    
elseif correctTrial(trial) == 0
    
    if strcmp(char(cardsDeck(trial).colour),char(cardsTable(indexSMA).colour))
        %o_EXT_PFC(1,tt:timeSteps) = -sigmf(o_EXT_PFC(1,tt) - pfcRate + randn*pfcNoise,[5 0.5]);
        o_EXT_PFC(1,tt:timeSteps) = satlin(o_EXT_PFC(1,tt) - bias_PFC);
       
        %o_EXT_PFC(1,tt:timeSteps) = 0;
        
        %fprintf('Inhibit COLOUR schema \n');
        %fprintf(fileID, '[TIME = %4.0f] Inhibit COLOUR Schema \n',tt);
    end
    
    if cardsDeck(trial).itemnum == cardsTable(indexSMA).itemnum  
        %o_EXT_PFC(2,tt:timeSteps) = -sigmf(o_EXT_PFC(2,tt) - pfcRate + randn*pfcNoise,[5 0.5]);
        o_EXT_PFC(2,tt:timeSteps) = satlin(o_EXT_PFC(2,tt) - bias_PFC);
       
        %o_EXT_PFC(2,tt:timeSteps) = 0;
        
        %fprintf('Inhibit NUMBER schema \n');
        %fprintf(fileID, '[TIME = %4.0f] Inhibit NUMBER Schema \n',tt);
  
    end
    
    if strcmp(char(cardsDeck(trial).shape),char(cardsTable(indexSMA).shape))
        %o_EXT_PFC(3,tt:timeSteps) = -sigmf(o_EXT_PFC(3,tt) - pfcRate + randn*pfcNoise,[5 0.5]);
        o_EXT_PFC(3,tt:timeSteps) = satlin(o_EXT_PFC(3,tt) - bias_PFC);
       
        %o_EXT_PFC(3,tt:timeSteps) = 0;
        
        %fprintf('Inhibit SHAPE schema \n');
        %fprintf(fileID, '[TIME = %4.0f] Inhibit SHAPE Schema \n',tt);
    end
    
end

%% Adds noise to the PFC schemas

o_EXT_PFC(:,tt:timeSteps) = o_EXT_PFC(:,tt:timeSteps) + randn*pfcNoise;

