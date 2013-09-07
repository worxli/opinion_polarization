function [ opvec ] = calcOpvec( arg )

    %%
    %retrieve arguments
    n=arg.agents;
    opinions=arg.opinions;
    rel=arg.relevancematrix;
    argmat=arg.argumentmatrix;
    k=arg.arguments;

    for i=1:n
        for l=1:opinions
            opvec(i,l)=rel(:,l,i)'*argmat(:,l,i);
        end
    end

end

