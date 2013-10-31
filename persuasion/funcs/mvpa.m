function r = mvpa(s,d)

    [n,m,o] = size(s);
    
    for i=1:n
        for j=1:m
            for k=1:o
                tmp=int16(s(i,j,k)*10^d);
                r(i,j,k)=double(tmp)/(10^d);
            end
        end
    end

end

