
clc;
clear;

% sets up unicode symbols for suits that will be used and stores them as strings
clubSym = string(char(9827));         % character is "♣"
diamondSym = string(char(9830));      % character is "♦"
heartSym = string(char(9829));        % character is "♥"
spadeSym = string(char(9824));        % character is "♠"

% sets up suits and ranks of cards
cardSuits = {"♣", "♦", "♥", "♠"};
cardRanks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"};

% game variables 
money = 100; % starting money for player
quitGame = false; % check if player wants to countinue with game
playerMove = ""; % intialise string varible to get player move
checkWinner = 0; % check winner variable

%stats 
handsPlayed = 0; % counts how many hands played
highestWin = zeros(2,1); % tracks biggest win
highestLoss = zeros(2,1); % tracks biggest loss


% prints the rules of the game
fprintf('By Nuwin Sooriyaarachchi (ID: a1900940)\n\n');
fprintf('- The goal is to get closer to 21 than the dealer without going over\n');
fprintf('- Number cards are worth their value\n');
fprintf('- Face cards are worth 10\n');
fprintf('- Aces are 1 and 11\n');
fprintf('- "hit" to get another card or "stand" to keep your current hand\n');
fprintf('- You can "double down" to double your bet and receive one more card\n');
fprintf('- If your total exceeds 21, you lose\n');
fprintf('- Once you stand, the dealer reveals their face-down card and draws until they reach 17\n');
fprintf('- If the dealer goes over 21, you win.\n');
fprintf('- If the dealer is closer to 21 than you, you lose\n');
fprintf('- If both you and the dealer have the same, it''s a tie and you get your bet back\n\n');

% waits for user to enter to continue
fprintf("Press enter to start game\n");
pause;
clc;

% checks player has enough money and wants to play game
while money > 0 && quitGame == false

    % resets variables 
    hitCount = 1; % resets hitcounter to 1
    bust = false; % resets bust to false 
    dealerBust = false; % reset dealer bust to false
    dealersHitCount = 1; % resets dealersHitCount to 1
    clc;
    
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


    % FOR DEALER

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
    dealersHandValue = cell(6,1); % all dealers hand values

    % when player drawing
    dealersHandImage{1} = downCard + cardImage{2};

    % give values for cards at different states
    dealersHandValue{1} = trueCardValue(dealersCardRanks{2}); % since first card is hidden to player
    dealersHandValue{2} = dealersHandValue{1} + trueCardValue(dealersCardRanks{1}); % when hidden card shown to player

    for i = 3:5
        dealersHandValue{i} = dealersHandValue{i-1} + trueCardValue(dealersCardRanks{i});
    end


    % when dealer drawing
    for i = 1:5
        dealersHandImage{i+1} = dealersJoinedBotCardImages{i} + dealersCardImages{i+1};
    end



    % FOR PLAYER

    % handle backend information for player
    playersCardImages = cell(12,1);
    playersBotCardImages = cell(12,1);
    playersCardRanks = cell(12,1);


    % assign for player
    for i = 7:18 % since cards 7-18 are for player
        playersCardImages{i-6} = cardImage{i};
        playersBotCardImages{i-6} = botCardImage{i};
        playersCardRanks{i-6} = drawnCardsRank{i};
    end


    playersJoinedBotCardImages = cell(12,1); % stores joined bot cards
    indexJoinBot = playersBotCardImages{1}; % helps create joined bot cards

    playersJoinedBotCardImages{1} = playersBotCardImages{1};


    % creates all possible needed botcards joined
    for i = 2:12
        playersJoinedBotCardImages{i} =  indexJoinBot + playersBotCardImages{i};
        indexJoinBot = playersJoinedBotCardImages{i};
    end

    % create hand images for player
    playersHandImage = cell(12,1);
    playersHandImage{1} = playersCardImages{1};
    for i = 1:11
        playersHandImage{i} = playersJoinedBotCardImages{i} + playersCardImages{i+1};
    end


    % handle players card values
    playersHandValue = cell(11,1);
    playersHandValue{1} = trueCardValue(playersCardRanks{1}) + trueCardValue(playersCardRanks{2});
    for i = 3:11
        playersHandValue{i-1} = playersHandValue{i-2} + trueCardValue(playersCardRanks{i});
    end

    fprintf("Money: %d\n\n", money);

    % asks player for bet amount
    while true; % runs until valid bet amount or quit
        clc; 
        bet = input(sprintf('How much do you want to bet (1-%d) or QUIT: ', money), 's');
        if strcmpi(bet, "QUIT") % checks if bet is "quit" (case-insensitive)
            quitGame = true; % marks as quit game
            break; % stops while loop
        end

        bet = str2double(bet); % make bet a double
        if bet > money || bet < 1 || isnan(bet) % checks if bet is greater than money, less than 0 or string that is not 'quit'
            fprintf('Invalid bet. Please enter a valid amount.');
        else
            money = money - bet; 
            break; % stops while loop
        end
    end
    
    if quitGame == true % quits game
        break;
    end

    clc;
    fprintf("Money: %d | Current Bet: %d", money,bet);
    fprintf("\n--------------\n"); %divider
    
        
    % print dealers starting cards
    printDealerHand(dealersHandValue,dealersHandImage, 1);
    
    fprintf("--------------\n"); %divider between dealer and player
    
    % prints players starting cards
    fprintf("%s\n", playersHandImage{1});
    printPlayerHandValue(playersHandValue, hitCount);
    
    % player actions loop 
    while true; 

        if bust == true % stops loop if player has bust       
            break;
        end

        while true; % gets player move or hand

            
            if hitCount == 1 &&  bet <= money  % can only double on the first hand 
                playerMove = upper(input("\nDo you want to (H)it, (S)tand or (D)ouble? ", 's'));
                if ismember(playerMove, ["H", "S", "D"])
                    break;
                else
                    fprintf("Invalid move. Please try again.\n");
                end

            else % if it is not the first hand or not enough money to double down
                playerMove = upper(input("\nDo you want to (H)it or (S)tand? ", 's'));
                if ismember(playerMove, ["H", "S"])
                    break;
                else
                    fprintf("Invalid move. Please try again.\n");
                end
            end
        end

        clc; % otherwise "Do you want to (H)it or (S)tand?" present


        % if player Hits 
        if strcmp(playerMove, "H")
            hitCount = hitCount +1;
            fprintf("Money: %d | Current Bet: %d", money,bet);
            fprintf("\n--------------\n"); %divider
            
                        
            % print dealers starting cards
            printDealerHand(dealersHandValue,dealersHandImage, 1);
            fprintf("--------------\n"); %divider between dealer and player
            
            % prints players starting cards
            fprintf("%s\n", playersHandImage{hitCount});
            printPlayerHandValue(playersHandValue, hitCount);

            [finalValue, bust] = checkIfBust(playersHandValue, hitCount); % checks if player has bust

        % if player double downs 
        elseif strcmp(playerMove,"D")
            money = money - bet; % change the amount of money left
            bet = bet+ bet; % double bet amount 
            
            hitCount = hitCount +1;
            [finalValue, bust] = checkIfBust(playersHandValue, hitCount); 
            fprintf("Money: %d | Current Bet: %d", money,bet);
            fprintf("\n--------------\n"); %divider
            
                        
            % print dealers starting cards
            printDealerHand(dealersHandValue,dealersHandImage, 1);
            fprintf("--------------\n"); % divider
            
            % prints players starting cards
            fprintf("%s\n", playersHandImage{hitCount});
            printPlayerHandValue(playersHandValue, hitCount); % % assigns final value to player 

            break; % leaves player actions while-loop

        % if player stands
        elseif strcmp(playerMove, "S") 

            [finalValue, bust] = checkIfBust(playersHandValue, hitCount); % assigns final value to player 
            

            break; % leaves player actions while loop

        end
        

        if finalValue > 21 % doesn't let the player hit if bust 
            bust = true;
            break; % leaves player actions while loop
        end

    end


    % players actions finished 

    handsPlayed = handsPlayed + 1; % increments handsPlayed 

    % if player has bust, exits current hand and decreases money
    if bust == true 
        fprintf("You Lost $%d!\n", bet);
        
        % checks if highest loss
        highestLoss(2) = bet;
        if highestLoss(2) > highestLoss(1)
            highestLoss(1) = highestLoss(2);
        end
        
        % wait for user to press button 
        fprintf("Press enter to countinue\n")
        pause;
        continue;
        
    end
    
    fprintf("");
    clc;


    % if player stood  
    while true; %dealer hit loop 
        fprintf(""); % wont clear without empty comment 
        clc; 
        dealersHitCount = dealersHitCount + 1; % increments dealershitCount by 1

        fprintf("Money: %d | Current Bet: %d", money,bet);
        fprintf("\n--------------\n"); %divider   

        % print dealers hands cards
        printDealerHand(dealersHandValue,dealersHandImage, dealersHitCount);
        fprintf("--------------\n"); %divider between dealer and player

        % prints players final hand 
        fprintf("%s\n", playersHandImage{hitCount});
        fprintf("PLAYER: %d\n", finalValue); % prints final value of player 

        [dealerBust, dealerFinalValue] = isDealer17(dealersHandValue, dealersHitCount);
        
        % exits loop if dealer has bust
        if dealerBust == true
            break;
        end

        if dealerFinalValue >= 17% breaks loop if dealer hits 17 or greater or has bust 
            clc;

            fprintf("Money: %d | Current Bet: %d", money,bet);
            fprintf("\n--------------\n"); %divider   
    
            % print dealers hands cards
            printDealerHand(dealersHandValue,dealersHandImage, dealersHitCount);
            fprintf("--------------\n"); %divider between dealer and player
    
            % prints players final hand 
            fprintf("%s\n", playersHandImage{hitCount});
            fprintf("PLAYER: %d\n", finalValue); % prints final value of player
            break % leaves dealer hit loop
        end
    
        pause(1); % waits one second before drawing next card 
        
    end

    

    % checks if player or dealer has higher card 
    checkWinner = finalValue > dealerFinalValue; % returns 1 if player won 
    
    % other conditions which change winner 
    if dealerBust == true
        checkWinner =1;
    elseif bust == true;
        checkWinner =0;
    end

    % checks if draw
    if finalValue == dealerFinalValue 
        checkWinner = 2;
    end

    pause(1);
    if dealerBust == false % if dealer didn't bust
        
        if checkWinner ==0 % if player lost
            fprintf("\nYou Lost $%d!\n", bet);
        elseif checkWinner == 1 % if player won
            fprintf("\nYou won $%d!\n", bet);
            money = money + bet*2; % increases money if won 
            
        else % if tied
            fprintf("\nYou tied!\n");
            money = money + bet;
        end
    else % if dealer bust 
        checkWinner = 1;
        fprintf("\nYou won $%d!\n", bet);
        money = money + bet*2; % increases money if won  
    end

    
    
    % checks if highest win and saves if true
    if checkWinner == 1 
        highestWin(2) = bet;
        if highestWin(2) > highestWin(1)
            highestWin(1) = highestWin(2);
        end
    % checks if highest loss and saves if true
    elseif checkWinner == 0
        highestLoss(2) = bet;
        if highestLoss(2) > highestLoss(1)
            highestLoss(1) = highestLoss(2);
        end
    end
        
    fprintf("Press enter to continue\n");
    pause; % waits for user to press something before starting next hand

    
end
    
clc;

if money == 0 
    fprintf("You're out of cash!\n");
    pause(1);
elseif quitGame == true
    fprintf("Quitting...\n");
    pause(1);
end

fprintf("Thanks for playing!\n");
pause(1);

% print stats
if handsPlayed ~= 0 % if played a hand 
    fprintf("\nStats:\n")
    fprintf("Hands Played: %d\n", handsPlayed);
    fprintf("Biggest Win: $%d\n", highestWin(1));
    fprintf("Biggest Loss: -$%d\n", highestLoss(1));
end































