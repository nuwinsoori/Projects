clc;
clear;

% prints the rules of the game 
% fprintf(['By Nuwin Sooriyaarachchi (ID: a1900940)\n\n', ...
%     '-The goal is to get a hand total closer to 21 than the dealer without going over.\n', ...
%     '-You start with two cards face up, while the dealer has one card face up and one face down.\n', ...
%     '-Number cards are worth their face value, face cards are worth 10, and Aces can be 1 or 11.\n', ...
%     '-You can "hit" to get another card or "stand" to keep your current hand.\n', ...
%     '-You can "double down" to double your bet and receive one more card.\n', ...
%     '-If your total exceeds 21, you lose.\n', ...
%     '-Once you stand, the dealer reveals their face-down card and draws until they reach 17 or higher.\n', ...
%     '-If the dealer goes over 21, you win. If the dealer''s total is closer to 21 than yours, you lose.\n', ...
%     '-If both you and the dealer have the same total, it''s a tie and you get your bet back.\n']);



% sets up unicode symbols for suits that will be used and stores them as strings
clubSym = string(char(9827));         % character is "♣"   
diamondSym = string(char(9830));      % character is "♦"
heartSym = string(char(9829));        % character is "♥"
spadeSym = string(char(9824));        % character is "♠"

% sets up starting amount of money 
money = 5000;


% define the deck of cards used for index 
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

    % replace n with cardRank accomodating for spacing if rank == 10
    if drawnCardsRank{i} == "10"
        newCardLine2 = strrep(if10cardLine2,"n", drawnCardsRank{i});
        newCardLine4 = strrep(if10cardLine4,"n", drawnCardsRank{i});
    else
        newCardLine2 = strrep(cardLine2,"n", drawnCardsRank{i});
        newCardLine4 = strrep(cardLine4,"n", drawnCardsRank{i});
    end

    %join the lines to create cardImage
    cardImage{i} = [cardLine1; newCardLine2; newCardLine3; newCardLine4; cardLine5];
end

% creates card for when dealers card is upside down line by line
downCardLine1 = ' ___ ';
downCardLine2 = '|#  |';                       
downCardLine3 = '| # |';              
downCardLine4 = '|  #|';
downCardLine5 = ' ‾‾‾ ';

% joines the lines to create downCardImage 
downCardImage = [downCardLine1; downCardLine2; downCardLine3; downCardLine4; downCardLine5];


%initalizes cell arrays for both the dealer and player cardImages
dealersCardImages = cell(5,1);
playersCardImages = cell(13,1);


% preassigns cards for both dealer and player 
% cards 1-6 is for dealer and 7-18 are for player 
for i = 1:18
    if i <= 6    
        dealersCardImages{i} = cardImage{i};
    else
        playersCardImages{i} = cardImage{i};
    end 
end
