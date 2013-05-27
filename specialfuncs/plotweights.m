xn=-1:0.1:1;
yn=[];
ynn=[];
bez=[0,0;0,0];
for x=xn
    y=upWeight(1,2,bez,[-1;x],2,5);
    yn=[yn;y(2,1)];
    y=old_upWeight(1,2,bez,[-1;x],2,5);
    ynn=[ynn;y(2,1)];
end
%yn
%ynn
%plot(xn,yn,xn,ynn);

xn=-1:0.1:1;
zn=-1:0.1:1;
yn=zeros(21);
ynn=zeros(21);
bez=[0,0;0,0];
a=3;
for x=xn
    for z=zn
        y=upWeight(1,2,bez,[z;x],1,a);
        yn((round(x*10)+11),round((z*10)+11))=y(2,1);
        y=old_upWeight(1,2,bez,[z;x],1,a);
        ynn(round(x*10)+11,round(z*10+11))=y(2,1);
    end
end

figure;
surf(xn,zn,yn);
hold on;
mesh(xn,zn,ynn);
mesh(xn,zn,zeros(21,21));