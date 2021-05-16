function plotCumCountP(path)
    session = load(path);
    autoCorr = getRateMapCorr(path, session);
    nullCorr = getShuffledCorr(path, 100);
    
    % calculate p-value
    pval = 1-mean(autoCorr > nullCorr, 2);
    
    % plot the cumulative p-value
    histogram(pval, 'Normalization', 'cumcount');
    