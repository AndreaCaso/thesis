%% Create and shuffle a deck of cards structure

cardsDeck = struct();

Itemnums = [1 2 3 4];
Shapes = {'triangle','star','cross','circle'};
Colours = {'red','green','yellow','blue'};

ii = 1;
for aa = 1:4 %randperm(64)
  for bb = 1:4
      for cc = 1:4
          
        cardsDeck(ii).itemnum = Itemnums(aa);
        cardsDeck(ii).shape = Shapes(bb);
        cardsDeck(ii).colour = Colours(cc);  
        ii = ii + 1;
        
      end
  end
end
% Shuffle
nn = 1;
for ii = randperm(64) 
   
    cardsDeck2(ii).itemnum = cardsDeck(nn).itemnum;
    cardsDeck2(ii).shape = cardsDeck(nn).shape;
    cardsDeck2(ii).colour = cardsDeck(nn).colour;
    nn = nn + 1;
    
end
cardsDeck = cardsDeck2;
clear cardsDeck2;

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
clear ii; clear nn; 

