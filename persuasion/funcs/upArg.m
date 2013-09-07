function [ argmat ] = upArg( arg )
    
    %%
    %retrieve arguments
    %agents
    i=arg.agenti;
    j=arg.agentj;
    
    %chosen issue
    op=arg.op;
    
    %relvance, argument and opinion vectors
    argmat=arg.argumentmatrix;
    targmat=arg.argumentmatrix;
    
    %argument chosen
    k=arg.k;
    
    %c exp
    c=arg.cexp;
    
    %update arguments for i and j
    if argmat(k,op,i)*argmat(k,op,j)>0
        argmat(k,op,i)=targmat(k,op,i)+targmat(k,op,j)*(1-abs(targmat(k,op,i)))^c; 
        argmat(k,op,j)=targmat(k,op,j)+targmat(k,op,i)*(1-abs(targmat(k,op,j)))^c; 
    else
        argmat(k,op,i)=(targmat(k,op,i)+targmat(k,op,j))/2;
        argmat(k,op,j)=argmat(k,op,i);
    end
   
end