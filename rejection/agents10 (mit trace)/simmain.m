clear all;

addpath ../funcs;

sim = true;

%%
if(sim)
    matlabpool('local', 12);
end

%profile on

%agents
n=10;

%runs
runs=50;

%homophily
h=10;

%issues (1 to 3)
%set to one
opinions=1;
    
%iterations
iter=2000;

%a
pa=1;

%all agents know each other -> all 1's
cont = ones(n,n);
minus = -1*ones(n,1);
cont = cont + diag(minus);
    
parfor r=1:runs

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
    arg = struct('agents',n,'maxiter',iter,'opinions',opinions,'cont',cont,'homophily',h,'run',r,'pa',pa,'opvec',opvec,'bez',bez,'c',2);
    arg.sim=false;
    
    %%
    %do simulation or visualizing
    if(sim)
        arg.sim=true;
        arg.maxiter=10^10;
        for hh=0:10
            arg.homophily = hh;
            arg = simupdate(arg);
        end
    else
        arg = simupdate(arg);
    end

end

%profile viewer

if(sim)
    matlabpool close
end
