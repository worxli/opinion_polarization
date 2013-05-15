xn=-1:0.1:1
yn=[];
bez=[0,0;0,0];
for x=xn
    y=upWeight(1,2,bez,[-1;x],2,5);
    yn=[yn;y(2,1)];
end
yn
plot((xn+1),yn);