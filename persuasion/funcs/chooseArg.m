function [k] = chooseArg( arg )

    %retrieve arguments
    k = arg.arguments;
    op = arg.op;
    i = arg.agenti;
    relmat = arg.relevancematrix;
    
    %%  
    %choose argument with the highest relevance with the highest
    %probability for agent i
    sumrel = 0;
    rd = rand(1,1);
    for kk=1:k
        sumrel = sumrel+relmat(kk,op,i);
        if(sumrel>=rd)
            k=kk;
            break;
        end
    end
    
end

