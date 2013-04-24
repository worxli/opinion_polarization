%data
scrsz = get(0,'ScreenSize');
figure('Position',[1 scrsz(4)/2-100 scrsz(3) scrsz(4)/2]);

data=data/n*100;
xv=-1:step:1;
yv=1:iter;

l=length(poldata);
if(l~=10)
    poldata=[poldata;zeros(10-l,1)];
end
poldata3d = interp1(1:diststep:iter,poldata,1:iter,'linear');
%da = [100*poldata3d',-10*ones(length(yv),length(xv)-1)];

for op=1:opinions
    subplot(1,opinions,op);
    
    surf1 = mesh(xv,yv,squeeze(data(op,:,:))');
    set(surf1,'FaceColor','red','FaceAlpha',0.5,'EdgeColor','black','EdgeAlpha',0.3);
    hold on;
    plot3(-1*ones(length(poldata3d)),yv,poldata3d*100);
    axis([-1 1 1 iter 0 100]);
    view(20,25);
    grid on;
    title(strcat('Opinion ' ,num2str(op)));
end

suptitle(strcat('Opinion Distribution, homophily: ',num2str(h)));
%figure;
%showPointCloud(n, opvec, opinions, 0, 0, 0, 1 );
%area(linspace(1,iter,length(poldata)),poldata);
%axis([1 iter 0 1]);