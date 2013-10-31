%%argument change calculator

x=-1:0.05:1;
chmati=zeros(size(x,2),size(x,2));
chmatj=zeros(size(x,2),size(x,2));

nmati=zeros(size(x,2),size(x,2));
nmatj=zeros(size(x,2),size(x,2));

c=1;

for i=1:size(x,2)
    for j=1:size(x,2)
        argmat(1)=x(i);
        argmat(2)=x(j);
        
        targmat=argmat;
        
        if argmat(1)*argmat(2)>0
            argmat(1)=targmat(1)+targmat(2)*(1-abs(targmat(1)))^c*abs(targmat(1));
            argmat(2)=targmat(2)+targmat(1)*(1-abs(targmat(2)))^c*abs(targmat(2));
        else
            argmat(1)=targmat(1)+1/2*(targmat(2)-targmat(1))*abs(targmat(1)*targmat(2));
            argmat(2)=targmat(2)+1/2*(targmat(1)-targmat(2))*abs(targmat(2)*targmat(1));
        end
        
        chmati(i,j)=argmat(1)-x(i);
        chmatj(i,j)=argmat(2)-x(j);
        
        nmati(i,j)=argmat(1);
        nmatj(i,j)=argmat(2);
    end
end


figure;
surf(x,x,chmati);
xlabel('j');
ylabel('i');
zlabel('Change of arg i');

figure;
surf(x,x,chmatj);
xlabel('j');
ylabel('i');
zlabel('Change of arg j');



figure;
surf(x,x,nmati);
xlabel('j');
ylabel('i');
zlabel('new value of arg i');

figure;
surf(x,x,nmatj);
xlabel('j');
ylabel('i');
zlabel('new value of arg j');