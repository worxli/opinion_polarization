function [ opvec ] = upOpinion( i, j, bez, opvec, opinions, c )

    topveci=opvec(i,:);
    topvecj=opvec(j,:);

    for k=1:opinions
        diff = bez(i,j)*(topvecj(k)-topveci(k))/c;
        if(diff>0)
            opvec(i,k)=topveci(k)+diff*(1-topveci(k));
        else
            opvec(i,k)=topveci(k)+diff*(1+topveci(k));
        end
        
        diff = bez(i,j)*(topveci(k)-topvecj(k))/c;
        if(diff>0)
            opvec(j,k)=topvecj(k)+diff*(1-topvecj(k));
        else
            opvec(j,k)=topvecj(k)+diff*(1+topvecj(k));
        end
    end
end

