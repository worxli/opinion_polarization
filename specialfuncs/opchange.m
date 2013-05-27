resi = zeros(21,21);
resj = zeros(21,21);
bez=zeros(21,21);

bez=zeros(21,21);
iv=1:21;
jv=1:21;
for ii=iv
    i=(ii-11)/10;
    for jj=jv
        j=(jj-11)/10;
        w = upWeight(1,2,[0,0;0,0],[i;j],1,1);
        bez(ii,jj)=w(1,2);
        op = upOpinion(1,2,w,[i;j],1,2);
        resi(ii,jj)=op(1,1)-i;
        resj(ii,jj)=op(2,1)-j;
    end
end
figure;
surf((iv-11)/10,(jv-11)/10,resi);
xlabel('j');
ylabel('i');
%hold on;
%figure;
%mesh((iv-11)/10,(jv-11)/10,resj);
%figure;
%surf((iv-11)/10,(jv-11)/10,bez);

siz=21;
grootresi = zeros(siz,siz);
grootresj = zeros(siz,siz);
bez=zeros(siz,siz);
iv=1:siz;
jv=1:siz;
for ii=iv
    i=(ii-11)/10;
    for jj=jv
        j=(jj-11)/10;
        w = upWeight(1,2,[0,0;0,0],[i;j],1,1);
        bez(ii,jj)=w(1,2);
        gop=degrootOp(1,2,w,[i;j],1,2);
        grootresi(ii,jj)=gop(1,1)-i;
        grootresj(ii,jj)=gop(2,1)-j;
    end
end


figure;
surf((iv-11)/10,(jv-11)/10,grootresi);
hold on;
mesh((iv-11)/10,(jv-11)/10,grootresj);


