function distribution = getSpatialInfoDistribution(path, numShuffle)
    %{
    Given the path of one session of recording, compute and return the
    distribution of spatial information content by shuffling the trace.
    %}

    session = load(path);
    distribution = zeros(size(session.processed.trace,1), numShuffle);
    lag = randi([900 size(session.processed.trace, 2)-900], numShuffle, 1);
    shuffledSession.environment = session.environment;
    shuffledSession.processed = session.processed;
    
    for i = 1:numShuffle
        shuffledTrace = circshift(session.processed.trace, lag(i), 2);
        shuffledSession.processed.trace = shuffledTrace;
        [infoRate,~] = getSpatialInfoContent(path, shuffledSession, false);
        distribution(:,i) = infoRate;
    end
end
        
        
        
        
        
        
    
