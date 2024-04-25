function [] = printDealerHand(dealersHandValue , dealersHandImage, index)
    % PRINTDEALERSHAND prints the value of dealers cards under 22
    
        if numel(dealersHandValue{index}) == 2
            if dealersHandValue{index}(2) > 21 % if second index is greater than 21 doesn't print that
                fprintf("DEALER: %d\n", dealersHandValue{index}(1));
            else
                fprintf("DEALER: %d \\ %d\n", dealersHandValue{index}(1), dealersHandValue{index}(2));
            end
        else
            fprintf("DEALER: %d\n", dealersHandValue{index});
        end
        fprintf("%s\n", dealersHandImage{index});
    end