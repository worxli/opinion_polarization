function [ rel ] = weightRel( arg )

    %%
    %retrieve arguments
    %agents
    i=arg.agenti;
    j=arg.agentj;
    
    %chosen argument
    k=arg.k;
    
    %chosen issue
    op=arg.op;
    
    %relvancematrix
    rel=arg.relevancematrix;
    
    %changed (new) values
    di = rel(k,op,i);
    dj = rel(k,op,j);
    
    %{
    %%
    %sum of arguments needs to be 1
    %agent i
    tmp = (1-di)./(sum(rel(:,op,i),1)-di);
    rel(:,op,i) = tmp.*rel(:,op,i);
    rel(k,op,i)=di;
    
    %agent j
    tmp = (1-dj)./(sum(rel(:,op,j),1)-dj);
    rel(:,op,j) = tmp.*rel(:,op,j);
    rel(k,op,j)=dj;
    
    %}
    
    tmp = 1./(sum(rel(:,op,i),1));
    rel(:,op,i) = tmp.*rel(:,op,i);
    
    tmp = 1./(sum(rel(:,op,j),1));
    rel(:,op,j) = tmp.*rel(:,op,j);
    
    rel(isnan(rel))=0;

end

