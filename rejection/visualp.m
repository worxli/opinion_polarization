function [] = visualp( arg, action )

    xv = -1:0.01:1;
    yv=1:arg.iter;
    h=0:0.5:10;

    switch action
        
        case 1
            
            figure;
            surf1 = surf(xv,yv,arg.data');
            colormap(flipud(gray));
            colorbar
            axis([-1 1 1 arg.iter 0 10]);
            view(20,25);
            grid on;
            
        case 2
            
            figure;
            plot(arg.data');
            axis([1 arg.iter -1 1]);
            
        case 3
            
            plot(arg.data);
            axis([1 arg.iter 0 1]);
            
        case 4
            %{
            figure;
            data = arg.iter;%(:,h+1);
            subplot(1,2,1);
            boxplot(data,h);
            title('Iterations');
            subplot(1,2,2);
            data = arg.pol;%(:,h+1);
            boxplot(data,h);
            hold on;
            plot(mean(data));
            %axis([0 6 -0.1 1.1]);
            title('Polarization');
            %}
            
            data = arg.pol;
            plot(h,mean(data));
            hold on;
            
            legend('a = 1', 'a = 1.25', 'a = 1.5');
            ylabel('average polarization');
            xlabel('homophily h');
            
        case 5
            figure;
            for i = 1:length(arg.pol(1,1,:))

                data1 = arg.pol(:,1:length(h),i);
                data2 = arg.pol(:,length(h)+1:length(h)*2,i);
                data3 = arg.pol(:,length(h)*2+1:end,i);
                

                subplot(2,2,i);
                title([num2str(arg.agents(i)) ' agents'] );
                hold on;
                g1 = plot(h, mean(data1),'r', 'LineWidth',4); 
                g2 = plot(h, mean(data2), 'LineWidth',4);
                g3 = plot(h, mean(data3), 'k', 'LineWidth',4);
                axis([0 10 0 1]);
                set(g2, 'Color', [0 0.5 1]);
                legend('a = 1', 'a = 1.25', 'a = 1.5');
                ylabel('average polarization');
                xlabel('homophily h');
                hold off;
            end
            
    end           
end