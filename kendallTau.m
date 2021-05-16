function [cellIdx, tauAttractor, tauDrift] = ...
    kendallTau(corrSingleCell, attractorTemplate, driftTemplate)
    cor = reshape(corrSingleCell, 32*32, 353);
    cells = reshape(sum(~isnan(cor),1) > 89, 353, 1);
    cellIdx = find(cells);
    cor = cor(:, cellIdx);

    tauAttractor = zeros(size(cor, 2), 1);
    tauDrift = zeros(size(cor, 2), 1);
    for cell = 1 : size(cor, 2)
        attractor = reshape(attractorTemplate, 32*32, 1);
        drift = reshape(driftTemplate, 32*32, 1);
        
        thisCell = cor(:, cell);
        attractor(isnan(thisCell), :) = [];
        drift(isnan(thisCell), :) = [];
        thisCell(isnan(thisCell)) = [];
        
        for i = 1 : length(thisCell)
            for j = i+1 : length(thisCell)
                tauAttractor(cell) = tauAttractor(cell) + ...
                    sign((thisCell(j)-thisCell(i)) * (attractor(j)-attractor(i)));
                tauDrift(cell) = tauDrift(cell) + ...
                    sign((thisCell(j)-thisCell(i)) * (drift(j)-drift(i)));
            end
        end
        
        tauAttractor(cell) = 2 * tauAttractor(cell) /...
            (length(thisCell) * (length(thisCell)-1));
        tauDrift(cell) = 2 * tauDrift(cell) / ...
            (length(thisCell) * (length(thisCell)-1));
    end
    
                

        
        