function [dIsBust, dValue ] = isDealer17(dealersHandValue, dealersHitCount)
    %ISDEALER17 checks if the dealer has reached a hand value of 17 or greater 

    dIsBust = false; % intialise dealers bust variable
   
    if numel(dealersHandValue{dealersHitCount}) == 2 % if there is an ace, takes the higher number if possible
        if dealersHandValue{dealersHitCount}(2) <= 21
            dValue = dealersHandValue{dealersHitCount}(2);
        elseif dealersHandValue{dealersHitCount}(1) <= 21
            dValue = dealersHandValue{dealersHitCount}(1);
    
        
        else % if can't take either value bust is true
            dIsBust = true;
            dValue = []; % no value since bust
        end
    
    % checks if there is no ace
    else
        % if value is less or equal 21 accepts that
        if dealersHandValue{dealersHitCount} <= 21
            dValue = dealersHandValue{dealersHitCount};
        %if value is greater than 21, bust is true
        else 
            dIsBust = true;
            dValue = []; % no value since bust
        end
    end
end