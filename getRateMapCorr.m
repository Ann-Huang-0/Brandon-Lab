function cor = getRateMapCorr(path, session)
    %{ 
    Args:
    path: used as input into getRateMapData, to find the environmental structure
    session: a data structure, either the same as the original one contained 
             in path, or a manually constructed one containing the position 
             and the shuffled trace
    mode: either 'mean' or 'peak'
    %}

    % get firing rate data
    [firstHalfFR, ~] = getRateMapData(path, session, 'mean', 'firstHalf' ,true);
    [secondHalfFR, ~] = getRateMapData(path, session, 'mean', 'secondHalf' ,true);
        
    % reshape the first two dimensions to 1d vector
    firstHalfFR = reshape(firstHalfFR, [], size(firstHalfFR, 3));
	firstHalfFR = firstHalfFR(~isnan(firstHalfFR(:,1)), :);
    secondHalfFR = reshape(secondHalfFR, [], size(secondHalfFR, 3));
    secondHalfFR = secondHalfFR(~isnan(secondHalfFR(:,1)), :);
    
    %{ 
    easy way of computing correlation
    cor = zeros(size(firstHalfFR,2),1);
    for idx = 1 : size(firstHalfFR, 2)
        corr_mat = corrcoef(firstHalfFR(:,idx), secondHalfFR(:,idx));
        cor(idx,:) = corr_mat(1,2);
    end
    %}
    
    % more effecient way of computing correlation
    cor = diag(corr(firstHalfFR, secondHalfFR));
    
end
    
    