function [] = printPlayerHandValue(playersHandValue, hitCount)  
    % PRINTPLAYERHANDVALUE prints the value of players cards under 22
    
        if numel(playersHandValue{hitCount}) == 2
            if playersHandValue{hitCount}(2) > 21 %if second index is greater than 21 doesn't print that
                fprintf("PLAYER: %d\n", playersHandValue{hitCount}(1));    % have to use \\ to print \
            else
                fprintf("PLAYER: %d \\ %d\n", playersHandValue{hitCount}(1), playersHandValue{hitCount}(2));    % have to use \\ to print \
            end
        else
            fprintf("PLAYER: %d\n", playersHandValue{hitCount});
        end
    end