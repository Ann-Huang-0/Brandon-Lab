function [sessARateMap, sessBRateMap] = pairWiseRegistration(folderPath, sessionPath,...
    allSessions, alignmentMap, dayA, dayB, plotting)
    
    pathA = strcat(folderPath, '/', sessionPath{dayA});
    pathB = strcat(folderPath, '/', sessionPath{dayB});
    sessionA = allSessions{dayA};
    sessionB = allSessions{dayB};
    
    % exclude cells that are not successfully aligned
    registration = alignmentMap{min(dayA, dayB), max(dayA, dayB)};
    registration = registration(all(registration, 2), :);
    
    % exclude non place cells
    placeCell = selectPlaceCell(sessionA);
    placeCell = placeCell(sessionA.processed.exclude.SFPs);
    registration(~ismember(registration(:,1), find(placeCell)),:) = [];
    
    % create two rate map matrix (19*19*numAlignedCells)
    sessARateMap = zeros(19, 19, length(registration));
    sessBRateMap = zeros(19, 19, length(registration));
    
    % get the rate maps of each aligned cell in two sessions
    [rateMapA, ~] = getRateMapData(pathA, sessionA, 'mean', 'noSplit', true);
    [rateMapB, ~] = getRateMapData(pathB, sessionB, 'mean', 'noSplit', true);
    rateMapA = rateMapA(:,:,sessionA.processed.exclude.SFPs);
    rateMapB = rateMapB(:,:,sessionB.processed.exclude.SFPs);
    for i = 1 : length(registration)
        sessARateMap(:,:,i) = rateMapA(:,:,registration(i, 1));
        sessBRateMap(:,:,i) = rateMapB(:,:,registration(i, 2));
    end
    
    % plot the rate map comparison between two sessions
    if plotting
        plotPairWiseRegistration(sessARateMap, sessBRateMap)
    end
        
    
    
    