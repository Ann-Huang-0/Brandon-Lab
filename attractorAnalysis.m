function [analysisMatrix, analysisCoefPerCell] = attractorAnalysis(corrMatrix, corrSingleCell, sessionPath)
    config = summarizeMorphStructures(sessionPath);
    configName = fieldnames(config);
    numSequence = length(config.Sq2);
    analysisMatrix = zeros(numSequence, 2, 6);
    analysisCoefPerCell = cell(numSequence, 2, 6);
    
    for i = 1 : numSequence 
        %idx of sessions to correlate with Sq1 in the current sequence
        idxSq = zeros(6,1);
        idxSq(1) = config.Sq1(i+1);
        for j = 2 : 6
            tmp = eval(['config.' configName{j}]);
            idxSq(j) = tmp(i);
        end
        %idx of sessions to correlate with G1 in the current sequence
        idxG = zeros(6,1);
        for k = 1 : 5
            tmp = eval(['config.' configName{k}]);
            idxG(k) = tmp(i);
        end
        idxG(6) = config.G1(i+1);
       
        for morph = 1 : 6
            analysisMatrix(i,1,morph) = corrMatrix(config.Sq1(i), idxSq(morph));
            analysisMatrix(i,2,morph) = corrMatrix(config.G1(i), idxG(morph));
            analysisCoefPerCell(i,1,morph) = corrSingleCell(config.Sq1(i),idxSq(morph));
            analysisCoefPerCell(i,2,morph) = corrSingleCell(config.G1(i),idxSq(morph));
        end
    end
end
            
