clear all;

addpath funcs;
%%

n=5;
c=2;

%%
%matlabpool close force local
%matlabpool('myprof', 2);
%matlabpool('local', 12);


runs=10;
hn=0:5;
hnn = num2cell(hn');

for pa=3:0.1:4
    
    bname = ['agents-' num2str(n) '-a-' num2str(pa) '-'];
    
    for o=1:3

        pol = [];
        cluster = [];
        iter = [];
        op = [];

       for h=hn
           
           disp(strcat(strcat('starting: ',num2str(pa)),strcat(' h: ',num2str(h))));

           tpol=zeros(runs,1);
           tcluster=zeros(runs,1);
           titer=zeros(runs,1);
           top=zeros(runs,1);

           %name = [bname 'op-' num2str(o) '-homo-' num2str(h)  '.txt'];
           %[fileID, msg] = fopen(name,'a');
           %if fileID == -1
           %     error(msg);
           % end
           parfor r=1:runs
               [tpol(r), tcluster(r), titer(r), top(r)] = simulation( n, c, r, o, h, pa );
               %disp(strcat(strcat('finished run: ',num2str(r)),strcat(' h: ',num2str(h))));
               %fprintf(fileID,'run %d -- ',r);
               %fprintf(fileID,'%8.4f %d %d %12.8f\n',tpol(r),tcluster(r),titer(r),top(r));
           end
           %fclose(fileID);

           pol = [pol,tpol];
           cluster = [cluster,tcluster];
           iter = [iter,titer];
           op = [op,top];


       end
       h=figure('Name',strcat('Issues: ',num2str(o)));
       subplot(2,2,1);
       boxplot(pol,'labels',hnn)
       xlabel('Homophily');
       ylabel('Polarization');
       subplot(2,2,2);
       boxplot(cluster,'labels',hnn)
       xlabel('Homophily');
       ylabel('Custers');
       subplot(2,2,3);
       boxplot(iter,'labels',hnn)
       xlabel('Homophily');
       ylabel('iterations needed');
       subplot(2,2,4);
       boxplot(op,'labels',hnn);
       xlabel('Homophily');
       ylabel('average opinion (weigthed over opinions)');

       name = ['figs' '/' bname 'op' num2str(o) '.png'];
       print('-dpng',name);
    end
    
end

matlabpool close
