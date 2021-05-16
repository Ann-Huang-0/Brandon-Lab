function [coef, coefCellWise] = sessionSimilarity(sessARateMap, sessBRateMap, corrMode)
    if strcmp(corrMode, 'Pearson')
        % vectorize the rate map for each cell
        sessARateMap = reshape(sessARateMap, [], size(sessARateMap,3));
        sessBRateMap = reshape(sessBRateMap, [], size(sessBRateMap,3));
        % remove the pixel if it's NaN in either sessionA or sessionB
        if sum(isnan(sessARateMap)) >= sum(isnan(sessBRateMap))
            nanIdx = find(isnan(sessARateMap(:,1)));
        elseif sum(isnan(sessBRateMap)) > sum(isnan(sessARateMap))
            nanIdx = find(isnan(sessBRateMap(:,1)));
        end
        sessARateMap(nanIdx, :) = [];
        sessBRateMap(nanIdx, :) = [];  
        % compute the correlation coefficient for each cell
        coefCellWise = diag(corr(sessARateMap, sessBRateMap));
        coef = mean(coefCellWise);
    end
end
