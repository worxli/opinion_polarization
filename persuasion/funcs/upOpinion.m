function [ rel ] = upOpinion( arg, a )
    
    %%
    %retrieve arguments
    %agents
    i=arg.agenti;
    j=arg.agentj;
    
    %chosen issue
    op=arg.op;
    
    %relvance, argument and opinion vectors
    rel=arg.relevancematrix;
    argvec=arg.argumentvector;
    opvec=arg.opvec;
    
    %get argument
    if(a==1)
        k = arg.ki;
    else
        k = arg.kj;
    end
    
    %%
    %update relevance
    reli = rel(k,op,i);
    relj = rel(k,op,j);
    
    %just take the middle of the relevances...
    
    %to change
    nreli=(reli+relj)/2;
    nrelj=(reli+relj)/2;
    %
    
    rel(k,op,i) = nreli;
    rel(k,op,j) = nrelj;
   
end

