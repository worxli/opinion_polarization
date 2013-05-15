function [ opvec ] = degrootOp( i, j, bez, opvec, opinions, c )
    
    opvec = (opvec+1)/2;
    bez = (bez+1)/2;
    bi=0.15;
    topveci=opvec(i,:);
    topvecj=opvec(j,:);
        
    for k=1:opinions
        
        opvec(i,k) = (topveci(k)+topveci(k)^bi*bez(i,j)*topvecj(k))/(1+topveci(k)^bi*bez(i,j)*topvecj(k)+(1-topveci(k))^bi*bez(i,j)*(1-topvecj(k)));
        opvec(j,k) = (topvecj(k)+topvecj(k)^bi*bez(i,j)*topveci(k))/(1+topvecj(k)^bi*bez(i,j)*topveci(k)+(1-topvecj(k))^bi*bez(i,j)*(1-topveci(k)));
    end
    
    opvec = opvec*2-1;

end

