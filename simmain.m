clear all;

%%
%create some log
formatOut = 'mm-dd-yy';
date = datestr(now,formatOut);
formatTime = 'HH-MM-SS';
time = datestr(now,formatTime);
folder = ['logs\' date];
name = [folder '\' time '.txt'];
mkdir(folder);
diary (name);

%%
%profile on;
matlabpool myprof 4;

runs=50;
n=1:5;
hn=[0,2.^(n-1)];
hnn = num2cell(hn');

for o=1:3
    
    pol = [];
    cluster = [];
    iter = [];
    op = [];
   
   for h=hn
       
       tpol=zeros(runs,1);
       tcluster=zeros(runs,1);
       titer=zeros(runs,1);
       top=zeros(runs,1);
       
       parfor r=1:runs
           [tpol(r), tcluster(r), titer(r), top(r)] = simulation( r, o, h );
           disp(strcat(strcat('finished run: ',num2str(r)),strcat(' h: ',num2str(h))));
       end
       
       pol = [pol,tpol];
       cluster = [cluster,tcluster];
       iter = [iter,titer];
       op = [op,top];
       
   end
   figure('Name',strcat('Issues: ',num2str(o)));
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
end

%profile viewer;
matlabpool close
diary off