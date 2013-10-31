function [ opvec ] = upOpinion( arg )
    
    %%
    %retrieve arguments
    %agents
    i=arg.agenti;
    j=arg.agentj;
    
    %chosen issue
    op=arg.op;
    
    %relvance, argument and opinion vectors
    rel=arg.relevancematrix;
    argmat=arg.argumentmatrix;
    opvec=arg.opvec;
    
    %%
    opvec(i,op)=rel(:,op,i)'*argmat(:,op,i);
    opvec(j,op)=rel(:,op,j)'*argmat(:,op,j);
   
end

