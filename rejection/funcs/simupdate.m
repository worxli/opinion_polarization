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
  
        %weight
        arg.bez = upWeight( arg.agenti, arg.agentj, arg.bez, arg.opvec, arg.opinions, arg.pa );

        %opinion
        arg.opvec = upOpinion( arg.agenti, arg.agentj, arg.bez, arg.opvec, arg.opinions, arg.c );  
        
        if(~arg.sim)
            data = createVisData( arg.opvec, loop, 0.1, data );
            %opchange = [opchange,arg.opvec];
            pol = [pol;calPol(arg.agents, arg.opvec, arg.opinions)];
        end
        
        if mod(loop,n/2)==0
            
            %gleichgewichte
            gl = calGleichgewichte(arg.agents, arg.opvec, arg.bez, arg.opinions, arg.c, arg.pa, arg.h);
            if(gl==1)
                arg.gl = loop;
                arg.pol = calPol(arg.agents, arg.opvec, arg.opinions);
                if arg.sim
                    disp('gl');
                    break;
                end
            end
            
            %%
            %check if if the run will reach a polarized eq. in the future
            %for sure
            if loop>2.5e06
                tmp1=zeros(n,1)';
                tmp2=zeros(n,1)';
                tmp1(find(arg.opvec>0.75))=1;
                tmp2(find(arg.opvec<-0.75))=1;
                tmp=tmp1+tmp2;
                if sum(tmp)==arg.agents
                    arg.opvec(find(arg.opvec>0.75))=1;
                    arg.opvec(find(arg.opvec<-0.75))=-1;
                    arg.gl = loop;
                    arg.pol = calPol(arg.agents, arg.opvec, arg.opinions);
                    if arg.sim
                        disp('never geting back together');
                        break;
                    end
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
        op = arg.opvec;
        op(find(op>0.95))=1;
        op(find(op<-0.95))=-1;
        arg_end.opvec = op;
        arg_end.gl=loop;
        arg_end.pol=calPol(arg.agents, arg.opvec, arg.opinions);
        save(['h' num2str(arg.h) '-a-' num2str(arg.pa) '-run-' num2str(arg.run) '.mat'],'arg_end', '-append');
    end
    