function compareSpatialInfoContent(path)
    %{
    Compare the spatial information content between the actual trace and
    the shuffled trace using p-value
    %}
    session = load(path);
    [actualInfo,~] = getSpatialInfoContent(path, session, false);
    shuffledDist = getSpatialInfoDistribution(path, 100);
    
    % calculate p-value
    pval = mean(shuffledDist > actualInfo, 2);
    
    % plot cumulative count of p-values
    histogram(pval, 'Normalization', 'cumcount');