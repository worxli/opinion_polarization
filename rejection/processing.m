clear all;

%% parameters
homophily=0:0.5:10;
runs=1:50;
agents=[10,20,50,100];
aa=1:0.25:1.5;

%%what to do?
% 1 = opiniondistribution
% 2 = opinionchange
% 3 = polarization
% 4 = run summary
action = 4;
%agents=10;
%aa=1.5;
%homophily=1;

%not needed for action 4
run = 9;

hhhpol = [];
it = 0;
%%
%looping through all combinations
for ag=agents
    
    it=it+1;
    hhpol = [];
    
    %%foldername
    foldername = ['ag' num2str(ag) ''];
    
    for a=aa
        
        hiter = [];
        hpol = [];
    
        for h=homophily

            if action ~= 4

                %%filename
                filename = ['h' num2str(h) '-a-' num2str(a) '-run-' num2str(run) '.mat']; 

                %%get data from .mat file
                data = load([foldername '/' filename]);
                arg_start = data.arg_start;
                %arg_end = data.arg_end;

                %get # of iterations
                gl = 10000000;
                %gl = arg.gl;

                %stepsize for graph
                step = ceil(gl/100000);

                %create empty datastructs
                vdata = [];
                opmat = [];

                %size of .mat files
                opstart = 1;
                loop = 50000;

                %loop through iterations stepwise
                for it=2:ceil(step/10):10000000
                    while it>loop
                        opstart=loop+1;
                        loop=loop+50000;
                    end

                    %try to open file
                    try
                        opmat = data.(['opvec' num2str(opstart) 'to' num2str(loop)]);
                    catch err
                        opmat = data.opvecend;
                    end

                    %extract opvec at step location
                    vdata = [vdata,opmat(:,it-opstart)];
                end

                [~,arg.iter] = size(vdata);

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

            else

                iter = [];
                pol = [];

                for r=runs

                    %%filename
                    filename = ['h' num2str(h) '-a-' num2str(a) '-run-' num2str(r) '.mat'];

                    if exist([foldername '/' filename], 'file')

                        mat = load([foldername '/' filename]);
                        if ismember('arg_end', fieldnames(mat))

                            arg_end = load([foldername '/' filename],'arg_end');
                            arg_end = arg_end.arg_end;

                            pol = [pol;arg_end.pol];
                            iter = [iter;arg_end.gl];

                        else 
                            %disp('no end');
                        end
                    else
                        disp([foldername '/' filename]);
                    end

                end
                
                l=length(iter); 
                if l<50
                    ag
                    h
                    l
                    a
                end
                
                iter = [iter;zeros(50-length(iter),1)];
                
                pol = [pol;zeros(50-length(pol),1)];

                hiter = [hiter,iter];
                hpol = [hpol,pol];

            end   
        end
    
        if action == 4
           % arg.pol = hpol;
           % arg.iter = hiter;
           % visualp(arg,4);
        end
        hhpol = [hhpol,hpol];
    end
    hhhpol(:,:,it)=hhpol;
end
arg.agents = agents;
arg.pol = hhhpol;
arg.iter = hiter;
visualp(arg,5);