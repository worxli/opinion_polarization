%%
%constants

%show pointcloud 1 = yes and 0 = no
pc=0;

%agents
n = 100;

%issues
opinions = 3;

%iterations
iter = 5000;

%homophily
h = 0;

%divisionfactor for delta opinion
c = 2;

%parameter for the beta distribution -> 20.8 is uniform distribution
x=1;

%%
beta = exp(x/30)-1;
%opvec = betarnd(beta,beta,n,opinions)*2-1;
opvec = [-0.5*ones(n/2,1),-0.5*ones(n/2,1),-0.5*ones(n/2,1)];
opvec = [opvec;[0.5*ones(n/2,1),0.1*ones(n/2,1),0.5*ones(n/2,1)]];

%opvec=[-1:0.01:1]';

%relations between agents computed based on their opinions
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
%graph options

%number of piles
switch n
    case num2cell(1:10)
        piles = n;
    case num2cell(11:20)
        piles = round(n/2);
    case num2cell(21:50)
        piles = round(n/4);
    otherwise
        piles = round(n/5);
end

step = 2/piles;

data = zeros(opinions,piles+1,iter);
poldata = [];

diststep = iter/10;
figure;
%showPointCloud(n, opvec,opinions, 0, 0, 0, 1 );