function [ rel ] = upRel( arg )
    
    %%
    %retrieve arguments
    %agents
    i=arg.agenti;
    j=arg.agentj;
    
    %chosen issue
    op=arg.op;
    
    %relvance, argument and opinion vectors
    rel=arg.relevancematrix;
    trel=arg.relevancematrix;
    
    %argument chosen
    k=arg.k;
    
    %c exp
    c=arg.cexp;
    
    %update relevances for i and j
    rel(k,op,i)=trel(k,op,i)+trel(k,op,j)*(1-trel(k,op,i))^c;
    rel(k,op,j)=trel(k,op,j)+trel(k,op,i)*(1-trel(k,op,j))^c;
    
end