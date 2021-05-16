function plotAttractorAnalysis(analysisMatrix, analysisCoefPerCell)
    mkdir('/Users/ann/Desktop/Lab/Plot/AttactorAcrossTime')
    x = [1,2,3,4,5,6];
    for seq = 1 : size(analysisMatrix,1)
        % line plot for averaged rate map correlation
        plot(x, squeeze(analysisMatrix(seq,2,:)), x, squeeze(analysisMatrix(seq,1,:)),...
            'Linewidth', 2)
        hold on
        plot(x, zeros(6,1), '--black', 'Linewidth', 2)
        xlim([0.6 6.4])
        ylim([-0.5 1])
        xticklabels({'Sq1','Sq2','Sq3','G3','G2','G1'})
        xlabel('Environment')
        ylabel('Rate map correlation(r)')
        set(gcf, 'Position', [100 00 400 500])

        % scatter plot for individual cell rate map correlation
        for env = 1 : 6
            sSq = scatter(ones(length(analysisCoefPerCell{seq,1,env}),1) * (env-0.05),...
                analysisCoefPerCell{seq,1,env}, 50, 'filled');
            sG = scatter(ones(length(analysisCoefPerCell{seq,2,env}),1) * (env+0.05),...
                analysisCoefPerCell{seq,2,env}, 50, 'filled');
            sSq.MarkerFaceAlpha = 0.15;
            sSq.MarkerFaceColor = '#A2142F';
            sG.MarkerFaceAlpha = 0.15;
            sG.MarkerFaceColor = '#0072BD';
        end
        hold off
        
        % save plot
        saveas(gcf, [fullfile('/Users/ann/Desktop/Lab/Plot/AttactorAcrossTime',...
            strcat('Sequence', num2str(seq), '.jpeg'))]);
    end
end