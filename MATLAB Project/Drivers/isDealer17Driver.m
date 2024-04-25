% first value is true or false dealers hand is 17 or greater 
% second value is highest hand value under 22
dealersHandValue{1} = 18;
[dIsBust, dValue ] = isDealer17(dealersHandValue, 1);

fprintf("%d %d\n", dIsBust, dValue);

dealersHandValue{1} = [15,26];
[dIsBust, dValue ] = isDealer17(dealersHandValue, 1);

fprintf("%d %d\n", dIsBust, dValue);


dealersHandValue{1} = [22];
[dIsBust, dValue ] = isDealer17(dealersHandValue, 1);

fprintf("%d %d\n", dIsBust, dValue);