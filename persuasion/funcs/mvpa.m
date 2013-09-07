function r = mvpa(s,d)

    [n,m] = size(s);
    
    for i=1:n
        for j=1:m
            tmp=int16(s(i,j)*10^d);
            r(i,j)=double(tmp)/(10^d);
        end
    end

end

