
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

% deck is shuffled after every hand 

% sets up unicode symbols for suits that will be used and stores them as strings
clubSym = string(char(9827));         % character is "♣"   
diamondSym = string(char(9830));      % character is "♦"
heartSym = string(char(9829));        % character is "♥"
spadeSym = string(char(9824));        % character is "♠"

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


% intialise cell arrays to identify rank and suits of drawn cards (for card images)
drawnCardsRank = cell(18,1);
drawnCardsSuit = cell(18,1);

% store the suits and ranks of all the drawnCards
for i = 1:length(drawnCards)
    drawnCardsRank{i} = drawnCards{i}(1:end-1);
    drawnCardsSuit{i} = drawnCards{i}(end);
end


% initalise cell array for both the botCardImages and cardImages (NOT JOINED YET)
cardImage = cell(18, 1);
botCardImage = cell(18,1);

% create images for botCardImages and cardImagse 
for i = 1:18

    % create each line of the card seperately 
    cardLine1 = ' ___ ';
    cardLine2 = '|r  |';              % r will be replaced with drawnCardsRank            
    cardLine3 = '| s |';              % s will be replaced with drawnCardsSuit
    cardLine4 = '|  r|';
    cardLine5 = ' ‾‾‾ ';

    % create new variable is cardRank is 10 as it changes spacing 
    if10cardLine2 = '|r |';              
    if10cardLine4 = '| r|';

    % when cards are at bottom of stack
    botCardLine1 = ' __';
    botCardLine2 = '|r ';
    botCardLine3 = '| s';
    botCardLine4 = '|  ';
    botCardLine5 = ' ‾‾';

    % change in spacing if rank is 10 
    if10botcardLine2 = '|r';


    % replace s with CardSuit
    cardLine3 = strrep(cardLine3, "s", drawnCardsSuit{i});
    botCardLine3 = strrep(botCardLine3, "s", drawnCardsSuit{i});

    % replace n with cardRank accomodating for spacing is rank == 10;
    if drawnCardsRank{i} == "10"

        % for top-most cards
        cardLine2 = strrep(if10cardLine2,"r", drawnCardsRank{i});
        cardLine4 = strrep(if10cardLine4,"r", drawnCardsRank{i});

        % for cards on bottom 
        botCardLine2 = strrep(if10botcardLine2, "r", drawnCardsRank{i});
    else
        % for cards on top 
        cardLine2 = strrep(cardLine2,"r", drawnCardsRank{i});
        cardLine4 = strrep(cardLine4,"r", drawnCardsRank{i});

        %for cards on bottom 
        botCardLine2 = strrep(botCardLine2, "r", drawnCardsRank{i});
    end


    %join the lines to create cardImage and botCardImage
    cardImage{i} = [cardLine1; cardLine2; cardLine3; cardLine4; cardLine5;];
    botCardImage{i} = [botCardLine1; botCardLine2; botCardLine3; botCardLine4; botCardLine5];
end

% creates card for when dealers card is upside down line by line
downCardLine1 = ' __';
downCardLine2 = '|# ';                       
downCardLine3 = '| #';              
downCardLine4 = '|  ';
downCardLine5 = ' ‾‾';
downCard = [ downCardLine1; downCardLine2; downCardLine3; downCardLine4; downCardLine5];


% for dealer

% handle backend information for dealer 
dealersCardImages = cell(6,1); % top card images 
dealersBotCardImages = cell(6,1); % bot card images 
dealersCardRanks = cell(6,1); % dealers card ranking

for i = 1:6 % assign to dealer
    dealersCardImages{i} = cardImage{i};
    dealersBotCardImages{i} = botCardImage{i};
    dealersCardRanks{i} = drawnCardsRank{i};
end

dealersJoinedBotCardImages = cell(6,1); % stores joined bot cards 
indexJoinBot = dealersBotCardImages{1}; % helps create joined bot cards

dealersJoinedBotCardImages{1} = dealersBotCardImages{1};

% creates all possible needed botcards joined 
for i = 2:6 % starts at 2 since starting at 1 will lead to double of same
    dealersJoinedBotCardImages{i} =  indexJoinBot + dealersBotCardImages{i};
    indexJoinBot = dealersJoinedBotCardImages{i};
end

% handle frontend information for dealer 
dealersHandImage = cell(6,1); % all dealers handstate images 
dealersCardValue = cell(6,1); % all dealers hand values  


% when player drawing 
dealersHandImage{1} = downCard + cardImage{2}; 
dealersCardValue{1} = trueCardValue(cardRanks{2}); 

for i = 1:6
    disp(dealersJoinedBotCardImages{i});
    disp(dealersCardImages{i});
end


when dealer drawing 
for i = 1:5
    dealersHandImage{i+1} = dealersJoinedBotCardImages{i} + dealersCardImages{1+1};
end

fprintf("%s\n", dealersHandImage{2});


% for player 
playersCardImages = cell(6,1);
playersBotCardImages = cell(6,1);
playersCardRanks = cell(6,1);

% assign for player
for i = 7:18 % since cards 7-18 are for player 
    playersCardImages{i-6} = cardImage{i};
    playersBotCardImages{i-6} = botCardImage{i};
    playersCardRanks{i-6} = drawnCardsRank{i};
end


        

function value = trueCardValue(cardRank)
    switch cardRank
        case {'J', 'Q', 'K'}
            value = 10;
        case 'A'
            % For 'A', it can be both 11 and 1
            value = [1, 11];
        otherwise
            % For other cards, the value is the number itself
            value = str2double(cardRank);
    end
end




% for player 
% playersCardImagesList = cell(12,1);
% playersCardRanks = cell(12,1);








% botCardImages and cardImages combined 











% % joines the lines to create downCardImage 
% downCardImage = [downCardLine1; downCardLine2; downCardLine3; downCardLine4; downCardLine5];

% %initalizes cell arrays for both the dealer and player 









% % preassigns both card ranks and images for both dealer and player 
% % 1-6 is for dealer and 7-18 are for player 
% for i = 1:18
%     if i <= 6    
%         dealersCardImagesList{i} = cardImage{i};
%         dealersCardRanks{i} = drawnCardsRank{i};
%     else
%         playersCardImagesList{i-6} = cardImage{i};
%         playersCardRanks{i-6} = drawnCardsRank{i};
%     end 
% end


% % HERE DOWNWARDS NEED WORK 
% % CHANGE GETTING CARD IMAGES AND RANKS TO AUTOMATIC 



% % for dealers cards 

% % creates images for dealers cards while player is still playing 
% dealersHandImages = downCardImage + dealersCardImagesList{1};
% dealersCardValue = trueCardValue(dealersCardRanks{1});

% % checks if dealersCardValue has 2 elements (due to an Ace)
% if numel(dealersCardValue) == 2
%     dealersCardValue = [1, 11];
%     fprintf("Dealer: %d \\ %d\n", dealersCardValue);    % have to use \\ to print \ 
% else
%     fprintf("Dealer: %d\n", dealersCardValue);
% end

% fprintf("%s\n", dealersHandImages);


% % for players cards

% % creates tracker for value of players cards 
% playersHandValue = trueCardValue(playersCardRanks{1}) + trueCardValue(playersCardRanks{2});


% % checks if playersHandValue has 2 elements (due to an Ace)
% if numel(playersHandValue) == 2 
%     fprintf("Player: %d \\ %d\n", playersHandValue(1), playersHandValue(2));
% else     
%     fprintf("Player: %d \n", playersHandValue);
% end

% fprintf("%s\n", playersCardImagesList{1} + playersCardImagesList{2});


