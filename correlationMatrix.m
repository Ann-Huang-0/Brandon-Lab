function [corrSingleCell, corrMatrix] = correlationMatrix(folderPath)
    corrMode = 'Pearson';
    corrMatrix = zeros(32,32);
    corrSingleCell = cell(32,32);
    sessionPath = summarizeSessionPath(folderPath);
    load(strcat(folderPath, '/', sessionPath{1}))
    alignmentMap = alignment.alignmentMap;
    allSessions = loadAllSessions(folderPath,sessionPath);
    
    for dayA = 1 : 32
        for dayB = 1 : 32
            if dayA == dayB
                corrMatrix(dayA, dayB) = 0;
            elseif dayA < dayB
                [sessARateMap, sessBRateMap] = pairWiseRegistration(...
                    folderPath, sessionPath, allSessions, alignmentMap, dayA, dayB, false);
                [coef, coefSingleCell] = sessionSimilarity(sessARateMap, sessBRateMap, corrMode);
                corrMatrix(dayA, dayB) = coef;
                corrMatrix(dayB, dayA) = coef;
                corrSingleCell(dayA, dayB) = {coefSingleCell};
            end
        end
    end
end