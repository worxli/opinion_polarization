function arg = simpudate( arg )    

    %%
    %retrieve arguments
    iter = arg.maxiter;
    opinions = arg.opinions;
    n = arg.agents;
    data=[];
    pol=[];
    opchange=[];
    
    opmat_len = 50000;
    opmat = [];
    gl = false;
    
    if(arg.sim)
        arg_start = arg;
        save(['h' num2str(arg.h) '-a-' num2str(arg.pa) '-run-' num2str(arg.run) '.mat'],'arg_start');
    end
    
    for loop=1:iter
        
        if(arg.sim&&arg.details)
            opmat = [opmat,arg.opvec];
            if mod(loop,opmat_len)==0
                opstart = loop-opmat_len+1;
                Data = struct(['opvec' num2str(opstart) 'to' num2str(loop)], opmat);
                save(['h' num2str(arg.h) '-a-' num2str(arg.pa) '-run-' num2str(arg.run) '.mat'], '-struct', 'Data', '-append');
                opmat = [];
            end   
        end

        %%
        %choose the agents
        [arg.agenti,arg.agentj]=chooseAgent(arg);

        %%
        %opinion or weight first
        p=rand(1);

        if(p>0.5)   
            %weight
            arg.bez = upWeight( arg.agenti, arg.agentj, arg.bez, arg.opvec, arg.opinions, arg.pa );

            %opinion
            arg.opvec = upOpinion( arg.agenti, arg.agentj, arg.bez, arg.opvec, arg.opinions, arg.c );  
        else  
            %opinion
            arg.opvec = upOpinion( arg.agenti, arg.agentj, arg.bez, arg.opvec, arg.opinions, arg.c );

            %weight
            arg.bez = upWeight( arg.agenti, arg.agentj, arg.bez, arg.opvec, arg.opinions, arg.pa );     
        end
        
        if(~arg.sim)
            data = createVisData( arg.opvec, loop, 0.02, data );
            opchange = [opchange,arg.opvec];
            pol = [pol;calPol(arg.agents, arg.opvec, arg.opinions)];
        end
        
        if mod(loop,n/2)==0
            
            %gleichgewichte
            gl = calGleichgewichte(arg.agents, arg.opvec, arg.bez, arg.opinions, arg.c, arg.pa);
            if(gl==1)
                arg.gl = loop;
                %arg.pol = calPol(arg.agents, arg.opvec, arg.opinions);
                if arg.sim
                    disp('gl');
                    break;
                end
            end
        end
            
    end
    
    if(~arg.sim)
        %save 'arg.mat' arg
        visual( arg, data, pol );
        %visopchange(opchange,iter);
    else
        if arg.details
            Data = struct('opvecend', opmat);
            save(['h' num2str(arg.h) '-a-' num2str(arg.pa) '-run-' num2str(arg.run) '.mat'], '-struct', 'Data', '-append');
        end
        
        arg_end = arg;
        save(['h' num2str(arg.h) '-a-' num2str(arg.pa) '-run-' num2str(arg.run) '.mat'],'arg_end', '-append');
    end
    