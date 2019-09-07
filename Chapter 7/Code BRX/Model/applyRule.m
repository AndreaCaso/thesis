% Apply rule according to the stimulus presented 

% Default
 weights.w_RULE_BASED = weights.w_RULE_BASE*eye(num_circles,num_rules); %default 
 
switch pfc.indexPFC(counter.trial_num)
    
 case 1
% From Clockwise Rule (1)
 rules.clockwise = [1 2; 2 3; 3 4; 4 5; 5 6; 6 7; 7 8; 8 9; 9 1];
 next_target = rules.clockwise(stimuli(counter.trial_num,2),2);
 weights.w_RULE_BASED (next_target,1) =  actW;
 
 case 2
% From Anticlockwise Rule (2)
 rules.anticlockwise = [1 9; 2 1; 3 2; 4 3; 5 4; 6 5; 7 6; 8 7; 9 8];
 next_target = rules.anticlockwise(stimuli(counter.trial_num,2),2);
 weights.w_RULE_BASED (next_target,2) =  actW;

 case 3
 % From Alternate (3)
 rules.alternate = [1 5;2 6; 3 7; 4 8; 5 1; 6 2; 7 3; 8 4; 9 2];
 next_target = rules.alternate(stimuli(counter.trial_num,2),2);
 weights.w_RULE_BASED (next_target,3) =  actW;

 case 4
% From Anticlockwise2 (4)
 rules.anticlockwise2 = [1 8;2 9; 3 1; 4 2; 5 3; 6 2; 7 5; 8 4; 9 7];
 next_target = rules.anticlockwise2(stimuli(counter.trial_num,2),2);
 weights.w_RULE_BASED (next_target,4) =  actW;
 
 case 5
% Any Other (5)
 rn = rules_set{5};
 rules.other = [1 rn(1);2 rn(2); 3 rn(3); 4 rn(4); 5 rn(5); 6 rn(6); 7 rn(7); 8 rn(8); 9 rn(9)];
 next_target = rules.other(stimuli(counter.trial_num,2),2);
 weights.w_RULE_BASED (next_target,5) =  actW;

end
%if newRule ~= 0
% fprintf('Apply Rule %i \n', pfc.indexPFC(counter.trial_num));
% newRule = 0;
%end