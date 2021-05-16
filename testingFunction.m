function corrMatrixCell = testingFunction(alignContinuous, alignmentMap, corrSingleCell, allSession)
    cell1 = alignContinuous(1,:);
    alignedSession = find(cell1);
    corrMatrixCell = NaN(32, 32);
    for i = 1 : length(alignedSession)
        for j = 1 : length(alignedSession)
            if i ~= j 
                % find which cells it is indexed in session i and session j
                dayA = alignedSession(i);
                dayB = alignedSession(j);
                idxCell = [cell1(dayA), cell1(dayB)];
                % find this pair of index corresponds to which row in
                % corrSingleCell(i,j)
                corrcoefs = cell2mat(corrSingleCell(dayA, dayB));

                registration = alignmentMap{min(dayA, dayB), max(dayA, dayB)};
                registration = registration(all(registration, 2), :);
                sessionA = allSession{min(dayA, dayB)};
                placeCell = selectPlaceCell(sessionA);
                placeCell = placeCell(sessionA.processed.exclude.SFPs);
                registration(~ismember(registration(:,1), find(placeCell)),:) = [];

                idxRow = find(registration(:,1) == idxCell(1));
                % if registration(idxRow, 2) == idxCell(2)
                corrMatrixCell(dayA, dayB) = corrcoefs(idxRow);
                corrMatrixCell(dayB, dayA) = corrcoefs(idxRow);
                % end  
            end
        end
    end

  
                
