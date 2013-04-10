%data
figure;

data=data/n*100;
xv=(-1+step/2):step:1;
yv=1:iter;

%meshc(xv,yv,data);
surf1 = surf(xv,yv,data(:,:,1));
set(surf1,'FaceColor','red','FaceAlpha',0.5,'EdgeColor','black','EdgeAlpha',0.3);

hold on;

%{
hold on;

surf2 = surf(xv,yv,data(:,:,2));
set(surf2,'FaceColor','blue','FaceAlpha',0.1,'EdgeColor','blue');

hold on;

surf3 = surf(xv,yv,data(:,:,3));
set(surf3,'FaceColor','green','FaceAlpha',0.1,'EdgeColor','green');

hold on;

surf4 = surf(xv,yv,data(:,:,4));
set(surf4,'FaceColor','white','FaceAlpha',0.1,'EdgeColor','white');

hold on;

surf5 = surf(xv,yv,data(:,:,5));
set(surf5,'FaceColor','yellow','FaceAlpha',0.1,'EdgeColor','yellow');
%}


poldata3d = interp1(1:diststep:iter,poldata,1:iter,'linear');
%da = [100*poldata3d',-10*ones(length(yv),length(xv)-1)];

%surf0 = surface(xv,yv,da);
%set(surf0,'FaceColor','blue','FaceAlpha',0.5,'EdgeColor','black','EdgeAlpha',1);

plot3(-1*ones(length(poldata3d)),yv,poldata3d*100);
axis([-1 1 1 iter 0 100]);
view(20,25);

grid on;

%figure;

%area(linspace(1,iter,length(poldata)),poldata);
%axis([1 iter 0 1]);