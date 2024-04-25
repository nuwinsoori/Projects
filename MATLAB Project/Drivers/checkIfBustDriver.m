% first value is the highest card (assuming less than 21) 
% second value true or false player bust 

playersHandValue{1} = [12,22];
[value, isBust] = checkIfBust(playersHandValue,1);

fprintf("%d %d\n", value, isBust);

playersHandValue{1} = [22];
[value, isBust] = checkIfBust(playersHandValue,1);

fprintf("%d %d\n", value, isBust);

playersHandValue{1} = [1,11];
[value, isBust] = checkIfBust(playersHandValue,1);

fprintf("%d %d\n", value, isBust);