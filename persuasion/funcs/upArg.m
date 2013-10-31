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
    c=arg.caexp;
    
    %update arguments for i and j
    if argmat(k,op,i)*argmat(k,op,j)>0
        argmat(k,op,i)=targmat(k,op,i)+targmat(k,op,j)*(1-abs(targmat(k,op,i)))^c*abs(targmat(k,op,i)); 
        argmat(k,op,j)=targmat(k,op,j)+targmat(k,op,i)*(1-abs(targmat(k,op,j)))^c*abs(targmat(k,op,j)); 
    else
        argmat(k,op,i)=targmat(k,op,i)+1/2*(targmat(k,op,j)-targmat(k,op,i))*abs(targmat(k,op,i)*targmat(k,op,j));
        argmat(k,op,j)=targmat(k,op,j)+1/2*(targmat(k,op,i)-targmat(k,op,j))*abs(targmat(k,op,j)*targmat(k,op,i));
    end
    
    if(argmat(k,op,i)==0)
        if(rand(1,1)>0.5)
            argmat(k,op,j)=0.01;
        else
            argmat(k,op,j)=(-1)*0.01;
        end
    end
    
    if(argmat(k,op,j)==0)
        if(rand(1,1)>0.5)
            argmat(k,op,j)=0.01;
        else
            argmat(k,op,j)=(-1)*0.01;
        end
    end
   
end