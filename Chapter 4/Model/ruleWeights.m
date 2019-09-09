%% According to the shown cards, sets the
% weights between the PFC and the SMA.
% Basically these dynamic weights are
% task dependent. Is it plausible?
% Check with Prof. Cooper

% On the table there are (from left to right)

% One Red Triangle
% Two Green Stars
% Three Yellow Crosses
% Four Blue Circles

% Resent PFC to SMA weights (TO-FROM)

Wparent = parBase*ones(4,3); % re-initialise to zero 
%wPar = 0.4;  % this parameter is essential
             % for the communication between cognitive
             % schemas (rules) and motor schemas

switch char(cardsDeck(trial).colour)
    case 'red'
        Wparent(1,1) = wPar;       
    case 'green'
        Wparent(2,1) = wPar;
    case 'yellow'
        Wparent(3,1) = wPar;
    case 'blue'
        Wparent(4,1) = wPar;
end

switch cardsDeck(trial).itemnum 
    case 1
        Wparent(1,2) = wPar;      
    case 2
        Wparent(2,2) = wPar;      
    case 3
        Wparent(3,2) = wPar;      
    case 4
        Wparent(4,2) = wPar;      
end

switch char(cardsDeck(trial).shape)
    case 'triangle'
        Wparent(1,3) = wPar;      
    case 'star'
        Wparent(2,3) = wPar;      
    case 'cross'
        Wparent(3,3) = wPar;      
    case 'circle'
        Wparent(4,3) = wPar;      
end

