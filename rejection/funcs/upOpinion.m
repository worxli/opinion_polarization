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
        
        diff = bez(j,i)*(topveci(k)-topvecj(k))/c;
        if(diff>0)
            opvec(j,k)=topvecj(k)+diff*(1-topvecj(k));
        else
            opvec(j,k)=topvecj(k)+diff*(1+topvecj(k));
        end
    end
    
    %{
    if abs(topveci(1))-abs(opvec(i,1))>0.2
       disp('old i, old j')
       topveci(1)
       topvecj(1)
       disp('bez')
       bez(i,j)
       disp('new i, new j');
       opvec(i,1)
       opvec(j,1)
       disp('---------------------');
    end
    
    %}
        
   
end

