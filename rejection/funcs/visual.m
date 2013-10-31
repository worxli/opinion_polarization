function [ ] = visual( arg, data, pol)

    iter=arg.maxiter;
    opinions=arg.opinions;
    poldata=0;
    n=arg.agents;
    poldata3d=pol;
    
    save 'data.mat' data
    
    if(~isempty(data))

        %data
        scrsz = get(0,'ScreenSize');
        %figure('Position',[1 scrsz(4)/2-100 scrsz(3) scrsz(4)/2]);
        figure('Position',[1 1 1800 480]);
        set(gcf,'renderer', 'zbuffer'); 

        data=data/n*100;
        xv=-1:0.02:1;
        yv=1:iter;

        for op=1:opinions
            subplot(1,opinions,op); 
            surf1 = surf(xv,yv,squeeze(data(op,:,:))');
            colormap(flipud(gray));
            colorbar
            %set(surf1,'FaceColor','red','FaceAlpha',1,'EdgeColor','black','EdgeAlpha',0.1);
            %hold on;
           % plot3(-1*ones(length(poldata3d)),yv,poldata3d*100);
            axis([-1 1 1 iter 0 100]);
            view(20,25);
            grid on;
            title(strcat('Opinion ' ,num2str(op)));
        end

        %name = ['figs' '/agents-'  num2str(n) '-iter-' num2str(iter) '-a-' num2str(pa) '.png'];
        %set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 5])
        %print('-dpng',name,'-r100');

        %suptitle(strcat('Opinion Distribution, homophily: ',num2str(h)));
        %figure;
        %showPointCloud(n, opvec, opinions, 0, 0, 0, 1 );
        %area(linspace(1,iter,length(poldata)),poldata);
        %axis([1 iter 0 1]);
    end
    
    if(~isempty(pol))
        figure;
        plot(pol);
       
    end

end

