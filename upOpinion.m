function [ opvec ] = upOpinion( i, j, bez, opvec, opinions, c )

    for k=1:opinions
        diff = bez(i,j)*(opvec(j,k)-opvec(i,k))/c;
        if(diff>0)
            opvec(i,k)=opvec(i,k)+diff*(1-opvec(i,k));
        else
            opvec(i,k)=opvec(i,k)+diff*(1+opvec(i,k));
        end
        
        diff = bez(i,j)*(opvec(i,k)-opvec(j,k))/c;
        if(diff>0)
            opvec(j,k)=opvec(j,k)+diff*(1-opvec(j,k));
        else
            opvec(j,k)=opvec(j,k)+diff*(1+opvec(j,k));
        end
    end

end

