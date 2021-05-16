function meanFR = getMeanFiringRate(trace, disp)
    %{ 
    Given matrix in the same format as processed.trace (numN * numTFrame),
    calculate and return the mean firing rate for each cell 
    %}

    meanFR = mean(trace, 2);
    if disp
        histogram(meanFR);
    end
    
end