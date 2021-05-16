function [infoRate, meanFR] = getSpatialInfoContent(path, session, disp)
    %{
    Given the position of the mouse and the place cell trace in one session,
    calculate the information rate of each cell using formula given by Skaggs_1997,
    in the pre-specified unit of bits per second or bits per timeframe.
    Notice that position can be replaced by any other discrete measureable
    variables, such as head position, or runnning speed.
    %}
    load(path);
    
    % the spatial mean firing rate & spatial firing probability 
    [meanPixelFR, spatialProb] = getRateMapData(path, session, 'mean', false, false);
    meanPixelFR(isnan(meanPixelFR)) = 0;  % assign NaN-value caused by morph boundaries to 0
    spatialProb(isnan(spatialProb)) = 0;
    
    % the overall mean firing rate of each cell
    numN = size(meanPixelFR, 3);
    meanFR = zeros(size(meanPixelFR));
    for i = 1 : numN
        meanFR(:,:,i) = meanFR(:,:,i) + sum(meanPixelFR(:,:,i) .* spatialProb, [1 2]);
    end
    
    % the information rate of each cell using formula in Skaggs_1997
    log = log2(meanPixelFR ./ meanFR);
    log(isinf(log)) = 0;
    infoRate = squeeze(sum(meanPixelFR .* spatialProb .* log, [1 2]));
    
    % unit convertion, bits/sec easier to compare with results in the paper
    infoRate = infoRate * 30;

    % display results
    if disp
        histogram(infoRate)
    end

end