function value = trueCardValue(cardRank)
    % TRUECARDVALUE assigns a value to all cards
    
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