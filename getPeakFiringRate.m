function peakFR = getPeakFiringRate(trace, disp)
    %{ 
    Given matrix in the same format as processed.trace (numN * numTFrame),
    calculate and return the peak firing rate for each cell 
    %}
    
    peakFR = max(trace, [], 2).';
    if disp
        histogram(peakFR);
    end
    
end