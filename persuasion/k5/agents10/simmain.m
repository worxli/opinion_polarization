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

%iterations
iter=2000;

%arguments (only persuasion)
k=5;

%exp for relevance -> no overshooting
cr = 1;

%exp for argument
ca = 1;

%all agents know each other -> all 1's
cont = ones(n,n);
minus = -1*ones(n,1);
cont = cont + diag(minus);
    
jobindex=str2double(getenv('LSB_JOBINDEX'));

for hh=h
    
    seed=cputime*1000;
    s = RandStream('mt19937ar','Seed',seed);
    RandStream.setGlobalStream(s);

    %create relevance matrix
    rel = rand(k,opinions,n);
    
    %{
    rel = zeros(k,opinions,n);
    for op=1:opinions
        for i=1:n
            rel(randi(k,1),op,i)=1;
        end
    end
    %}
    
    %bias sum to 1
    for i=1:n
        tmp = 1./sum(rel(:,:,i),1);
        for l=1:opinions
        	rel(:,l,i) = tmp(l).*rel(:,l,i);
        end
    end
    
    %argument vector
    %a=-1;b=1;
    %argmat = a + (b-a).*rand(k,opinions,n); 
    
    argmat = zeros(k,opinions,n);
    
    for kk=1:k
        for oo=1:opinions
            if kk<k/2+1
                argmat(kk,oo,:) = rand(1,1,n);
            else
                argmat(kk,oo,:) = (-1).*rand(1,1,n);
            end
        end
    end
    
    %set struct as argument
    arg = struct('agents',n,'maxiter',iter,'opinions',opinions,'arguments',k,'caexp', ca, 'crexp',cr,'cont',cont,'relevancematrix',rel,'argumentmatrix',argmat,'homophily',hh,'run',jobindex,'h',hh);
    arg.jobindex = jobindex;
    arg.details = details;
    arg.seed = seed;
   
    %calculate opinionvector from relevance and arguments
    arg.opvec = calcOpvec(arg);
    
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
