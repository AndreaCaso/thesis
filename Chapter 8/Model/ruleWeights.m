%% According to the shown cards, sets the
% weights between the PFC and the SMA.
% Basically these dynamic weights are
% task dependent. 
% HERE THERE IS A RACE MODEL IMPLEMENTED BEFORE 
% SELECTION

% On the table there are (from left to right)

% One Red Triangle
% Two Green Stars
% Three Yellow Crosses
% Four Blue Circles

% Resent PFC to SMA weights (TO-FROM)

weights.w_RULE_BASED = weights.w_RULE_BASE*ones(4,3); %default application of rules (usually 0)

counter.pfc_value = [pfc.o_PFC(1,tt-1) pfc.o_PFC(2,tt-1) pfc.o_PFC(3,tt-1)]; % Values of motor schemas
counter.area_pfc = counter.area_pfc + counter.pfc_value*counter.trial_num_time; % Area below motor schemas
 
if any(counter.area_pfc > thresholds.dynamic(tt)) && any(counter.pfc_value > thresholds.static)

pfc.indexPFC = find(counter.pfc_value == max(counter.pfc_value));
pfc.indexPFC = pfc.indexPFC(1);

if pfc.indexPFC == 1
 switch char(stimuli(counter.trial_num).colour)
     case 'red'
         weights.w_RULE_BASED(1,1) = weights.w_RULE_PRES;       
     case 'green'
         weights.w_RULE_BASED(2,1) = weights.w_RULE_PRES;
     case 'yellow'
         weights.w_RULE_BASED(3,1) = weights.w_RULE_PRES;
     case 'blue'
         weights.w_RULE_BASED(4,1) = weights.w_RULE_PRES;
 end
end

if pfc.indexPFC == 2
 switch stimuli(counter.trial_num).itemnum 
     case 1
         weights.w_RULE_BASED(1,2) = weights.w_RULE_PRES;      
     case 2
         weights.w_RULE_BASED(2,2) = weights.w_RULE_PRES;      
     case 3
         weights.w_RULE_BASED(3,2) = weights.w_RULE_PRES;      
     case 4
         weights.w_RULE_BASED(4,2) = weights.w_RULE_PRES;      
 end
end

if pfc.indexPFC == 3
 switch char(stimuli(counter.trial_num).shape)
    case 'triangle'
        weights.w_RULE_BASED(1,3) = weights.w_RULE_PRES;      
    case 'star'
        weights.w_RULE_BASED(2,3) = weights.w_RULE_PRES;      
    case 'cross'
        weights.w_RULE_BASED(3,3) = weights.w_RULE_PRES;      
    case 'circle'
        weights.w_RULE_BASED(4,3) = weights.w_RULE_PRES;      
 end
end

end