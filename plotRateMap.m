function plotRateMap(path, session, mode, splitHalf, smooth)
    % generate data for heatmap
    [rateMap, ~] = getRateMapData(path,session,mode,splitHalf,smooth);
    % exclude data for unwanted cells
    placeCell = selectPlaceCell(session);
    rateMap = rateMap(:, :, placeCell);
    numN = size(rateMap, 3); % number of neurons
    
    % set transparency value for different pixels
    % assume neurons within one session have the same NaN distribution
    alpha = ~isnan(rateMap(:,:,1));
    
    % plot and display rate map for each cell
    mkdir('/Users/ann/Desktop/Lab/RataMapPlot');
    for idx = 1 : numN
        imagesc(rateMap(:,:,idx), 'AlphaData', alpha);
        colormap('jet');  % change the colormap to jet
        set(gca, 'visible', 'off');  % turn off the axis
        saveas(gcf, strcat('Cell', num2str(idx)));  % save image figures
    end  
    
end