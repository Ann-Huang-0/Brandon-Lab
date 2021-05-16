function corrSingleCell = corrMatrixSingleCell(folderPath, sessionPath, allSessions,...
    alignContinuous)
    corrSingleCell = NaN(32, 32, size(alignContinuous,1));
    for dayA = 1 : 32
        for dayB = 1 : 32
            if dayA < dayB
                registration = [alignContinuous(:, dayA) alignContinuous(:, dayB)];
                [sessARateMap, sessBRateMap] = pairRegisCellAnalysis(folderPath, sessionPath,...
                    allSessions, dayA, dayB, registration);
                sessARateMap = reshape(sessARateMap, [], size(sessARateMap,3));
                sessBRateMap = reshape(sessBRateMap, [], size(sessBRateMap,3));
                morphA = findMorphSize([folderPath '/' sessionPath{dayA}]);
                morphB = findMorphSize([folderPath '/' sessionPath{dayB}]);
                if morphA(1) >= morphB(1)
                    nanIdx = isnan(sessARateMap(:, find(registration(:,1),1)));
                else
                    nanIdx = isnan(sessBRateMap(:, find(registration(:,2),1)));
                end
                sessARateMap(nanIdx, :) = [];
                sessBRateMap(nanIdx, :) = [];

                corrSingleCell(dayA,dayB,:) = diag(corr(sessARateMap, sessBRateMap));
                corrSingleCell(dayB,dayA,:) = diag(corr(sessARateMap, sessBRateMap));
            end
        end
    end
end
    
                        
                    