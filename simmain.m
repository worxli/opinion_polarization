clear all;

addpath ../funcs;

sim = true;
details = false;

%agents
n=10;

%homophily
h=0:10;

%issues (1 to 3)
%set to one
opinions=1;

%a
%pa=1;
aa=1:0.25:2;

%all agents know each other -> all 1's
cont = ones(n,n);
minus = -1*ones(n,1);
cont = cont + diag(minus);

jobindex=str2double(getenv('LSB_JOBINDEX'));

for pa=aa
for hh=h
    
    seed=cputime*1000;
    s = RandStream('mt19937ar','Seed',seed);
    RandStream.setGlobalStream(s);

    %create opvec
    a=-1;b=1;
    opvec = a + (b-a).*rand(n,opinions);

    %create bez
    bez = zeros(n,n);
    for i=1:n
        for j=i+1:n
           diff = norm(opvec(i,:)-opvec(j,:),1);
           bez(i,j) = 1 - diff/opinions;
           bez(j,i) = 1 - diff/opinions; 
        end
    end

    %all agents know each other -> all 1's
    cont = ones(n,n);
    minus = -1*ones(n,1);
    cont = cont + diag(minus);

    %set struct as argument
    arg = struct('agents',n,'opinions',opinions,'cont',cont,'homophily',hh,'run',jobindex,'pa',pa,'opvec',opvec,'bez',bez,'c',2,'h',hh);
    arg.sim=false;
    arg.jobindex = jobindex;
    arg.details = details;
    arg.seed = seed;
    
    %%
    %do simulation or visualizing
    if(sim)
        arg.sim=true;
        arg.maxiter=10^10;
        simupdate(arg);
    else
        arg = simupdate(arg);
    end
end
end