function [value, isBust] = checkIfBust(playersHandValue, hitCount)
    % CHECKIFBUST takes the highest value less than 21, if there is no value, bust is true
    
    isBust = false; % Initialize bust variable
    
    if numel(playersHandValue{hitCount}) == 2 % if there is an ace, takes the higher number if possible
        if playersHandValue{hitCount}(2) <= 21
            value = playersHandValue{hitCount}(2);
        elseif playersHandValue{hitCount}(1) <= 21
            value = playersHandValue{hitCount}(1);

        
        else % if can't take either value bust is true
            isBust = true;
            value = [playersHandValue{hitCount}(1)]; 
        end
    
    % checks if there is no ace
    else
        % if value is less or equal 21 accepts that
        value = playersHandValue{hitCount};
        if playersHandValue{hitCount} > 21
            isBust = true; %if value is greater than 21, bust is true
        
        end
    end
end