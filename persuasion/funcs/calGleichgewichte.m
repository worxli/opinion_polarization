function gl = calGleichgewichte(arg)
    
    n = arg.agents;
    k = arg.arguments;
    opvec = arg.opvec;
    op = arg.opinions;
    h = arg.homophily;
    gl = false;
    rel = arg.relevancematrix;
    argm = arg.argumentmatrix;
    
    eps = 0.01;
    
    if sum(abs(opvec))>=n-eps
        
        if (abs(sum(opvec))>=n-eps&&h==0)||h>0
            
            %find two groups
            gr1 = find(opvec>=1-eps);
            gr2 = find(opvec<=-1+eps);
            
            %%
            %process group one, positive opinion
            %find all indexes for relevances greater than 0
            rel1 = find(rel(:,1,gr1)>eps);
            
            %create temp argumentmatrix, only agents which belong to the
            %group
            tmp1 = argm(:,1,gr1);
            
            %%
            %group two, negative opinion
            rel2 = find(rel(:,1,gr2)>eps);
            tmp2 = argm(:,1,gr2);
            
            %%
            %check if number of arguments which are one is the same as
            %number of relevances greater than 0
            if (length(find(tmp1(rel1)>=1-eps))==length(rel1))&&(length(find(tmp2(rel2)<=-1+eps))==length(rel2))
                gl=true;
            end
        end
    end
end