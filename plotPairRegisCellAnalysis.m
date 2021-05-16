function plotPairRegisCellAnalysis(alignContinuous, corrSingleCell)
    mkdir('/Users/ann/Desktop/Lab/Plot/SingleCellAnalysis')
    for i = 1 : size(corrSingleCell,3)
        if sum(alignContinuous(i,:) ~= 0) >= 20
            alpha = ~isnan(corrSingleCell(:,:,i));
            imagesc(corrSingleCell(:,:,i), 'AlphaData', alpha);
            saveas(gcf, [fullfile('/Users/ann/Desktop/Lab/Plot/SingleCellAnalysis',...
                strcat('Cell', num2str(i), '.jpeg'))]);
        end
    end
end
        
        