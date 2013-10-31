clear all;

%% parameters
homophily=0:10;
runs=1:50;
agents=[10,20,50,100];

%%what to do?
% 1 = opiniondistribution
% 2 = opinionchange
% 3 = polarization
% 4 = run summary
action = 4;

%not needed for action 4
run = 1;


%%
%looping through all combinations
for a=agents
    
    %%foldername
    foldername = ['agents' num2str(a)];
    
    hiter = [];
    hpol = [];
    
    for h=homophily
        
        if action ~= 4
                
            %%filename
            filename = ['h' num2str(h) '-run-' num2str(run) '.mat']; 
            
            %%get data from .mat file
            data = load([foldername '/' filename]);
            arg_start = data.arg_start;
            arg_end = data.arg_end;
            
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
            for it=2:ceil(step/10):10000
                if it>loop
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
                    visual(arg, 1);
                case 2
                    arg.data = vdata;
                    visual(arg, 2);      
                case 3  
                    arg.data = calPol(vdata);
                    visual(arg, 3);  
            end
  
        else
            
            iter = [];
            pol = [];
            
            for r=runs

                %%filename
                filename = ['h' num2str(h) '-run-' num2str(r) '.mat'];
                
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
                    %disp([foldername '/' filename]);
                end
                
            end 
            
            iter = [iter;zeros(50-length(iter),1)];
            pol = [pol;zeros(50-length(pol),1)];
            
            hiter = [hiter,iter];
            hpol = [hpol,pol];
            
        end   
    end
    
    if action == 4
        arg.pol = hpol;
        arg.iter = hiter;
        visual(arg,4);
    end
end