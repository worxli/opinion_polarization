function [] = visualp( arg, action )

    h=0:0.5:10;

    switch action
        
        case 1
             xv = -1:0.01:1;
               yv=1:arg.iter;
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
            figure;
            data = arg.iter;
            subplot(1,2,1);
            boxplot(data,h);
            title('Iterations');
            subplot(1,2,2);
            data = arg.pol;
            boxplot(data,h);
            hold on;
            plot(mean(data));
            %axis([0 6 -0.1 1.1]);
            title('Polarization');
            
        case 5
            figure;
            data = arg.pol;
            boxplot(data,h);
            axis([0.1 22 -0.1 1.1]);
            xlabel('homophily');
            ylabel('polarization');
    end           
end