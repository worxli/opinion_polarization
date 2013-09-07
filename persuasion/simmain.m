clear all;

addpath funcs;

%%
%matlabpool close force local
%matlabpool('myprof', 4);
%matlabpool('local', 12);

%profile on

%agents
n=30;

%runs
runs=5;

%homophily
h=5;

%a (only used in rejection)
pa=1;

%issues (1 to 3)
opinions=1;

%iterations
iter=1000;

%arguments (only persuasion)
k=10;

%exp -> no overshooting
c=1;

%all agents know each other -> all 1's
cont = ones(n,n);
minus = -1*ones(n,1);
cont = cont + diag(minus);
    
for r=1:runs

    %create relevance matrix
    rel = rand(k,opinions,n);
    
    %bias sum to 1
    for i=1:n
        tmp = 1./sum(rel(:,:,i),1);
        for l=1:opinions
        	rel(:,l,i) = tmp(l).*rel(:,l,i);
        end
    end
    
    %argument vector
    a=-1;b=1;
    argmat = a + (b-a).*rand(k,opinions,n);
    
    %{
    %create relevance vectors
    for i=1:n
        for l=1:opinions
            rel(:,l,i)=randfixedsum(k,1);
            
            %{
            trel = randfixedsum(k,1);
            topvec = trel'*argvec(:,l);
            while(topvec(end)>(opvec(i,l)+0.1) || topvec(end)<(opvec(i,l)-0.1))
                trel = randfixedsum(k,1);
                topvec = [topvec;trel'*argvec(:,l)];
            end
            rel(:,l,i)=trel
            %}
        end
    end
    %}
    
    
    %set struct as argument
    arg = struct('agents',n,'maxiter',iter,'opinions',opinions,'arguments',k,'cexp',c,'cont',cont,'relevancematrix',rel,'argumentmatrix',argmat,'homophily',h);
    
    %arg.rel = rel;
    
    %calculate opinionvector from relevance and arguments
    arg.opvec = calcOpvec(arg);
    
    %%
    arg = simupdate(arg);

end

%profile viewer

%matlabpool close