%% Change rule
% if trial > 1
%% Change the rule if there are too many correct answers in a row
   
if ruleNum(trial) == 0 
   
    ruleNum(trial) = randi([1 3]); % Select Random Rule
    
    if ruleNum(trial) == 1 
        
           %fprintf('Changed rule to: sorting by COLOUR \n');
           ruleSet = 'sortByColour'; 
           %fprintf(fileID, '[TIME = %4.0f] Changed rule to: sorting by COLOUR \n',tt);
    
    elseif ruleNum(trial) == 2
          
           %fprintf('Changed rule to: sorting by NUMBER \n');
           ruleSet = 'sortByNumber';
           %fprintf(fileID, '[TIME = %4.0f] Changed rule to: sorting by NUMBER \n',tt);
     
    elseif ruleNum(trial) == 3 
           
           %fprintf('Changed rule to: sorting by SHAPE \n');
           ruleSet = 'sortByShape'; 
           %fprintf(fileID,'[TIME = %4.0f] Changed rule to: sorting by SHAPE \n',tt);
    
    end 

end


    