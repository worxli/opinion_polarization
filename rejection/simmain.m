clear all;

addpath funcs;

%%
matlabpool close force local
%matlabpool('myprof', 4);
matlabpool('local', 12);

n=10;
runs=50;
h=0;
pa=1;
opinions=1;
iter=10^8;
    
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

    %%
    simupdate( r, n, 2, iter, h, opinions, opvec, bez, cont, pa );

    end

matlabpool close