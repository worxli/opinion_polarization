function [] = visualp( arg )

    h=0:0.5:10;
    
    %{
    figure;
    data1 = arg.pol(:,1:length(h));
    data2 = arg.pol(:,length(h)+1:end);
    
    %boxplot(data1,h, 'colors', 'k'); hold on;
    %boxplot(data2,h, 'colors', 'b'); hold on;
    
    dat = {data1, data2};
    %aboxplot(dat,'labels', (0:0.5:10),'Colormap', [1 0 0; 0 0 1],  'WidthL', 0.7); hold on;
    
    g1 = plot(h, mean(data1),'r', 'LineWidth',4); 
    hold on;
    g2 = plot(h, mean(data2), 'LineWidth',4);
    
    set(g2, 'Color', [0 0.5 1]);
    
    xlabel('homophily h');
    ylabel('average polarization');
    
    legend('rejection model: agents: 100, a: 1.5', 'persuasion model');
    
    %}
    
    figure;
    for i = 1:length(arg.pol(1,1,:))
        i
        
        data1 = arg.pol(:,1:length(h),i)
        data2 = arg.pol(:,length(h)+1:end,i);
        
        subplot(2,2,i);
        g1 = plot(h, mean(data1),'r', 'LineWidth',4); 
        hold on;
        g2 = plot(h, mean(data2), 'LineWidth',4);
        set(g2, 'Color', [0 0.5 1]);
    end
    
end