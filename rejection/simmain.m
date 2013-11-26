clear all;

addpath funcs;

sim = true;
details = true;

%agents
n=100;

%runs
runs=1;

%homophily
h=20;

%issues (1 to 3)
%set to one
opinions=1;
    
%iterations
iter=2000;

%a
pa=2;

%all agents know each other -> all 1's
cont = ones(n,n);
minus = -1*ones(n,1);
cont = cont + diag(minus);

jobindex=str2double(getenv('LSB_JOBINDEX'));
    
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
    arg = struct('agents',n,'maxiter',iter,'opinions',opinions,'cont',cont,'homophily',hh,'run',jobindex,'pa',pa,'opvec',opvec,'bez',bez,'c',2,'h',hh);
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