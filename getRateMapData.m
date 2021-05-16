function [rateMap, spatialProb] = getRateMapData(path, session, mode, splitHalf, smooth)
    % retrive info about the position and neural firing from input structure 'session'
    p = getfield(session, 'processed', 'p');
    trace = getfield(session, 'processed', 'trace');
    numFrame = size(trace, 2);
    bin_size = 2;
    
    if strcmp(splitHalf, 'firstHalf')
        trace = trace(:, 1:floor(numFrame/2));
        p = p(:, 1:floor(numFrame/2));  
    elseif strcmp(splitHalf, 'secondHalf')    
        trace = trace(:, floor(numFrame/2)+1:end);
        p = p(:, floor(numFrame/2)+1:end);
    end
    
    % bin the environment by the specified bin_size
    steps = ceil(session.environment.size(1)/ bin_size);
    numN = size(trace, 1);
    numTFrame = size(trace, 2);
    % array initiation
    rateMap = zeros(steps, steps, numN); 
    spatialProb = zeros(steps, steps); 

    % sampling and get the average firing rate in each position bin
    for x = 1 : steps   
        x_range = bin_size * [x-1 x];
        x_inRange = (p(1,:)>= x_range(1) & p(1,:)<= x_range(2));
        for y = 1 : steps
            y_range = bin_size * [y-1 y];
            y_inRange = (p(2,:)>= y_range(1) & p(2,:)<= y_range(2));
            idx = x_inRange & y_inRange; % 1 at time frames when the mice is at position (x,y)
            spatialProb(x,y) = sum(idx) / numTFrame; % get the probability of mouse being in that pixel
            if sum(idx) == 0  % unaccessible pixels or unvisited pixels
                rateMap(x,y,:) = 0;
            else 
                if strcmp(mode, 'mean')
                    rateMap(x,y,:) = getMeanFiringRate(trace(:, idx), false);
                elseif strcmp(mode, 'peak')
                    rateMap(x,y,:) = getPeakFiringRate(trace(:, idx), false);
                end
            end
        end
    end

    % smooth the spatial firing map with Gaussian kernel   
    if smooth
        for idx = 1 : numN
            rateMap(:,:,idx) = imfilter(rateMap(:,:,idx),fspecial('gauss',round([4.*5 4.*5]./bin_size),4./bin_size),'same');
        end
    end
    
    % reassign unaccesible pixels caused by environmental boundaries to NaN
    morphSize = findMorphSize(path);
    rateMap(1:morphSize(1), steps-morphSize(2):steps, :) = NaN;
    rateMap(steps-morphSize(1):steps, 1:morphSize(2), :) = NaN;
    spatialProb(1:morphSize(1), steps-morphSize(2):steps, :) = NaN;
    spatialProb(steps-morphSize(1):steps, 1:morphSize(2), :) = NaN;
 
end




