%% Create and shuffle a deck of cards structure

stimuli = struct();

Itemnums = [1 2 3 4];
Shapes = {'triangle','star','cross','circle'};
Colours = {'red','green','yellow','blue'};

ii = 1;
for aa = 1:4 
  for bb = 1:4
      for cc = 1:4
          
        stimuli(ii).itemnum = Itemnums(aa);
        stimuli(ii).shape = Shapes(bb);
        stimuli(ii).colour = Colours(cc);  
        ii = ii + 1;
        
      end
  end
end

% Get 64 cards

stimuli = [stimuli];

% Shuffle
nn = 1;
for ii = randperm(length(stimuli)) 
   
    stimuli2(ii).itemnum = stimuli(nn).itemnum;
    stimuli2(ii).shape = stimuli(nn).shape;
    stimuli2(ii).colour = stimuli(nn).colour;
    nn = nn + 1;
    
end

stimuli = stimuli2;
clear stimuli2;

%% Cards on the table

cardsTable(1).colour = 'red';
cardsTable(2).colour = 'green';
cardsTable(3).colour = 'yellow';
cardsTable(4).colour = 'blue';

cardsTable(1).shape = 'triangle';
cardsTable(2).shape = 'star';
cardsTable(3).shape = 'cross';
cardsTable(4).shape = 'circle';

cardsTable(1).itemnum = 1;
cardsTable(2).itemnum = 2;
cardsTable(3).itemnum = 3;
cardsTable(4).itemnum = 4;

clear aa; clear bb; clear cc;
clear Shapes; clear Itemnums; clear Colours;

clear ii; clear nn; clear ans;

