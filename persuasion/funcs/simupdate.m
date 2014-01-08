function arg = simpudate( arg )  

    %%
    %retrieve arguments
    iter = arg.maxiter;
    opinions = arg.opinions;
    arguments = arg.arguments;
    data=[];
    pol=[];
    opchange=[];
    
    opmat_len = 50000;
    opmat = [];
    
    if(arg.sim)
        arg_start = arg;
        save(['h' num2str(arg.h) '-run-' num2str(arg.run) '.mat'],'arg_start');
    end
    
    %%    
    for loop=1:iter
        if(arg.sim&&arg.details)
            opmat = [opmat,arg.opvec];
            
            if mod(loop,opmat_len)==0
                %arg.argumentmatrix
                %arg.relevancematrix
                opstart = loop-opmat_len+1;
                Data = struct(['opvec' num2str(opstart) 'to' num2str(loop)], opmat);
                save(['h' num2str(arg.h) '-run-' num2str(arg.run) '.mat'], '-struct', 'Data', '-append');
                opmat = [];
            end
        end
    
        %choose the agents
        [arg.agenti,arg.agentj]=chooseAgent(arg);

        %choose an opinion
        arg.op = randi(opinions,1);
        
        %choose argument
        arg.k = chooseArg(arg);
        
        %update relevances or arguments
        arg.argumentmatrix = upArg(arg);
        arg.relevancematrix = upRel(arg); 
        
        %calc weighted relevance
        arg.relevancematrix = weightRel(arg);
        
        %compute opinions
        arg.opvec = upOpinion( arg );
        
        if(~arg.sim)
            data = createVisData( arg.opvec, loop, 0.1, data );
            opchange = [opchange,arg.opvec];
            pol = [pol;calPol(arg.agents, arg.opvec, arg.opinions)];
        end
        
        if(calGleichgewichte(arg))
            arg.gl = loop;
            arg.pol = calPol(arg.agents, arg.opvec, arg.opinions);
            disp('gl');
            break;
        end
             
    end  
    
    if(~arg.sim)
        %save 'arg.mat' arg
        visual( arg, data, pol );
        %visopchange(opchange,iter);
    else 
        if arg.details
            Data = struct('opvecend', opmat);
            save(['h' num2str(arg.h) '-run-' num2str(arg.run) '.mat'], '-struct', 'Data', '-append');
        end
        arg_end = arg;
        save(['h' num2str(arg.h) '-run-' num2str(arg.run) '.mat'],'arg_end', '-append');
    end