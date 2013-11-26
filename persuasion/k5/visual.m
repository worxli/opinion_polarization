function [] = visual( arg, action )

    xv = -1:0.01:1;
    yv=1:arg.iter;

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
            figure;
            subplot(1,2,1);
            boxplot(arg.iter);
            title('Iterations');
            subplot(1,2,2);
            boxplot(arg.pol);
            axis([0 22 -0.1 1.1]);
            title('Polarization');
    end           
end