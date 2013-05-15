function [pol, cluster, iterations, op] = simulation( n, c, r, opinion, homophily )

%%
%set up constants

%iterations
iter=10^10;

%homophily
h=homophily;

%opinions
opinions=opinion;

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
[ pol, cluster, iterations, op ] = simupdate( r, n, c, iter, h, opinions, opvec, bez, cont );

end

