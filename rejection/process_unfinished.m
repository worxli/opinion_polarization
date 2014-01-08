%%what to do?
% 1 = opiniondistribution
% 2 = opinionchange
% 3 = polarization
% 4 = run summary
action = 3;
run = 1;
a=4;
h=0;
ag=50;

%%foldername
foldername = ['ag' num2str(ag)];

%%filename
filename = ['h' num2str(h) '-a-' num2str(a) '-run-' num2str(run) '.mat'];

%%get data from .mat file
data = load([foldername '/' filename]);
arg_start = data.arg_start;

%get # of iterations
gl = 10000;
%gl = arg.gl;

%stepsize for graph
step = ceil(gl/2000);

%create empty datastructs
vdata = [];
opmat = [];

%size of .mat files
opstart = 1;
loop = 50000;

%loop through iterations stepwise
for it=2:ceil(step/10):10^5
    if it>loop
        opstart=loop+1;
        loop=loop+50000;
    end
    
    %try to open file
    try
        opmat = data.(['opvec' num2str(opstart) 'to' num2str(loop)]);
    catch err
        %opmat = data.opvecend;
    end
    
    %extract opvec at step location
    vdata = [vdata,opmat(:,it-opstart)];
end
    
switch action
    case 1
        arg.data = histc(vdata,[-1:0.01:1]);
        visualp(arg, 1);
    case 2
        arg.data = vdata;
        visualp(arg, 2);
    case 3
        arg.data = calcPol(vdata);
        visualp(arg, 3);
end