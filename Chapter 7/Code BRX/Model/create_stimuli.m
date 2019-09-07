%% Create and shuffle a deck of cards structure

stimuli  = importdata('sequence.txt',' ' );

% In stimuli the fist column is the number of the sequence
% The second is the number of the circle that is filled in
% in that trial.
% The third one is what the response would be if the subject
% continue on the previous rule.