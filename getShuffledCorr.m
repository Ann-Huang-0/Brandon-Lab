function nullCorr = getShuffledCorr(path, numShuffle)
    session = load(path);
    nullCorr = zeros(size(session.processed.trace, 1), numShuffle);
    lag = randi([900 size(session.processed.trace, 2)-900], numShuffle, 1);
    
    % construct structure array to input into getRateMapData
    nullSession.environment = session.environment;
    nullSession.processed = session.processed;
    
    % shuffle the trace and get corr_coef for each shuffling
    for i = 1:numShuffle
        nullTrace = circshift(session.processed.trace, lag(i), 2);
        nullSession.processed.trace = nullTrace;
        nullCorr(:,i) = getRateMapCorr(path, nullSession, 'mean');
    end

end