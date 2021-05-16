function [sessARateMap, sessBRateMap] = pairRegisCellAnalysis(folderPath, sessionPath,...
    allSessions, dayA, dayB, registration)
    
    pathA = strcat(folderPath, '/', sessionPath{dayA});
    pathB = strcat(folderPath, '/', sessionPath{dayB});
    sessionA = allSessions{dayA};
    sessionB = allSessions{dayB};

    % create two rate map matrix (19*19*numAlignedCells)
    sessARateMap = zeros(19, 19, length(registration));
    sessBRateMap = zeros(19, 19, length(registration));
    
    % get the rate maps of each aligned cell in two sessions
    [rateMapA, ~] = getRateMapData(pathA, sessionA, 'mean', 'noSplit', true);
    [rateMapB, ~] = getRateMapData(pathB, sessionB, 'mean', 'noSplit', true);
    rateMapA = rateMapA(:,:,sessionA.processed.exclude.SFPs);
    rateMapB = rateMapB(:,:,sessionB.processed.exclude.SFPs);
    
    for i = 1 : size(rateMapA, 3)
        idxA = registration(:,1) == i;
        if sum(idxA) ~= 0
            sessARateMap(:,:,idxA) = rateMapA(:,:,i);
        end
    end   
    
    for j = 1 : size(rateMapB, 3)
        idxB = registration(:,2) == j;
        if sum(idxB) ~= 0
            sessBRateMap(:,:,idxB) = rateMapB(:,:,j);
        end
    end
end
    
    
    