% APRIL 8TH


clc;
clear;

cardSuits = {"♣", "♦", "♥", "♠"};
cardRanks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"};

% Generate a deck of cards
deck = cell(length(cardSuits) * length(cardRanks), 1);
index = 1;
for i = 1:length(cardSuits)
    for j = 1:length(cardRanks)
        deck{index} = [cardRanks{j} cardSuits{i}];
        index = index + 1;
    end
end

% Draw 18 unique cards
drawnIndex = randperm(length(deck), 18);
drawnCards = deck(drawnIndex);

% store the ranks of all the drawnCards
drawnCardsRank = cell(18,1);
for i = 1:length(drawnCards)
    drawnCardsRank{i} = drawnCards{i}(1:end-1);
end

% stores the suits of all the drawn cards
drawnCardsSuit = cell(18,1);
for i = 1:length(drawnCards)
    drawnCardsSuit{i} = drawnCards{i}(end);
end


% intialise cell array for cardImages 
cardImage = cell(18, 1);

% create images for all drawn cards and store in cell array
for i = 1:18


    % create each line of the card seperately 
    cardLine1 = ' ___ ';
    cardLine2 = '|n  |';              % n will be replaced with drawnCardsRank            
    cardLine3 = '| r |';              % s will be replaced with drawnCardsSuit
    cardLine4 = '|  n|';
    cardLine5 = ' ‾‾‾ ';

    % create new variable is cardRank is 10 as it changes spacing 
    if10cardLine2 = '|n |';              
    if10cardLine4 = '| n|';


    % replace r with CardSuit
    newCardLine3 = strrep(cardLine3, "r", drawnCardsSuit{i});

    % replace n with cardRank accomodating for spacing is rank == 10;
    if drawnCardsRank{i} == "10"
        newCardLine2 = strrep(if10cardLine2,"n", drawnCardsRank{i});
        newCardLine4 = strrep(if10cardLine4,"n", drawnCardsRank{i});
    else
        newCardLine2 = strrep(cardLine2,"n", drawnCardsRank{i});
        newCardLine4 = strrep(cardLine4,"n", drawnCardsRank{i});
    end

    %join the lines to create cardImage
    cardImage{i} = [cardLine1; newCardLine2; newCardLine3; newCardLine4; cardLine5;];
end

% creates card for when dealers card is upside down line by line
downCardLine1 = ' ___ ';
downCardLine2 = '|#  |';                       
downCardLine3 = '| # |';              
downCardLine4 = '|  #|';
downCardLine5 = ' ‾‾‾ ';

% joines the lines to create downCardImage 
downCardImage = [downCardLine1; downCardLine2; downCardLine3; downCardLine4; downCardLine5];


%initalizes cell arrays for both the dealer and player 
dealersCardImages = cell(5,1);
dealersCardRanks= cell(5,1);
playersCardImages = cell(13,1);
playersCardRanks = cell(13,1);

% preassigns both card ranks and images for both dealer and player 
% 1-6 is for dealer and 7-18 are for player 
for i = 1:18
    if i <= 6    
        dealersCardImages{i} = cardImage{i};
        dealersCardRanks{i} = drawnCardsRank{i};
    else
        playersCardImages{i} = cardImage{i};
        playersCardRanks{i} = drawnCardsRank{i};
    end 
end


% for dealers cards 

% creates images for dealers cards while player is still playing 
startingDealersHandImages = downCardImage + dealersCardImages{1};
startingDealersCardValue = trueCardValue(dealersCardRanks{1});

% check if the dealers starting hand has an A and format accordingly 
if dealersCardRanks{1} == 'A'
    startingDealersCardValue = [1, 11];
    fprintf("Dealer: %d \\ %d\n", startingDealersCardValue);    % have to use \\ to print \ 
else
    fprintf("Dealer: %d\n", startingDealersCardValue);
end




% for players cards








function value = trueCardValue(drawnCardsRank)
    switch drawnCardsRank
        case {'J', 'Q', 'K'}
            value = 10;
        case 'A'
            % For 'A', it can be both 11 and 1
            value = [11, 1];
        otherwise
            % For other cards, the value is the number itself
            value = str2double(drawnCardsRank);
    end
end