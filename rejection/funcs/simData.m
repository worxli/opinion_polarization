function [ pol, op, cluster] = simData(n, opvec, opinions  )
    
    %calculate polarization      
    pol = calPol(n,opvec, opinions);
    
    %op
    op = sum(sum(opvec))/(n*opinions);
    
    %cluster
    opvec = unique(opvec,'rows');
    [cluster,~] = size(opvec);

end

