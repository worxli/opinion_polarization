function arg = simpudate( arg )  

    %%
    %retrieve arguments
    iter = arg.maxiter;
    opinions = arg.opinions;
    arguments = arg.arguments;
    data = [];
    pol=[];
    
    %%    
    for loop=1:iter

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
        arg.opvec = calcOpvec( arg );
        
        %arg.opvec
        
        data = createVisData( arg.opvec, loop, 0.01, data );
        pol = [pol;calPol(arg.agents, arg.opvec, arg.opinions)];
             
    end  
    
    save 'arg.mat' arg
    
    visual( arg, data, pol );