function plotPairWiseRegistration(sessARateMap, sessBRateMap)
    mkdir('/Users/ann/Desktop/Lab/PairwiseRegisPlotting');
    alphaA = ~isnan(sessARateMap(:,:,1));
    alphaB = ~isnan(sessBRateMap(:,:,1));
    for i = 1 : size(sessARateMap, 3)
        subplot(1,2,1)
        imagesc(sessARateMap(:,:,i), 'AlphaData', alphaA);
        colormap('jet');  
        set(gca, 'visible', 'off');
        subplot(1,2,2)
        imagesc(sessBRateMap(:,:,i), 'AlphaData', alphaB);
        colormap('jet');  
        set(gca, 'visible', 'off');
        saveas(gcf, [fullfile('/Users/ann/Desktop/Lab/PairwiseRegisPlotting',...
            strcat('Cell', num2str(i)))]);
    end 
end
        