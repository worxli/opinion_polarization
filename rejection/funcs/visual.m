function [ ] = visual( arg, data, pol)

    iter=arg.maxiter;
    opinions=arg.opinions;
    poldata=0;
    n=arg.agents;
    poldata3d=pol;
    
    save 'data.mat' data
    
    if(~isempty(data))

        scrsz = get(0,'ScreenSize');
        %figure('Position',[1 scrsz(4)/2-100 scrsz(3) scrsz(4)/2]);
        figure('Position',[1 1 1800 480]);
        set(gcf,'renderer', 'zbuffer'); 
        
        ma = 1;%2*max(max(max(data)));
        data=data/ma;
        xv=-1:0.001:1;
        yv=1:iter;

            surf1 = surf(xv,yv,squeeze(data(1,:,:))');
            set(surf1,'EdgeColor','none','LineStyle','none');
            
            colormap(flipud(gray));
            colorbar
            %set(surf1,'FaceColor','black','FaceAlpha',1,'EdgeColor','white','EdgeAlpha',1);
            %hold on;
           % plot3(-1*ones(length(poldata3d)),yv,poldata3d*100);
            axis([-1 1 1 iter 0 n]);
            view(20,25);
            grid on;
            
            xlabel('opinion');
            ylabel('simulation events');
            zlabel('number of agents');
            
            %title(strcat('Opinion ' ,num2str(op)));

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

