function [i,j] = chooseAgent( n,opvec,opinions,h )

%chose random agent -> i
    i = randi(n,1);
    
    %find a contact for the agent -> j
    
    for jj=1:n
       hdist(jj,1)=norm(opvec(i)-opvec(jj),1)/(2*opinions);
    end
    
    hdist(i)=2;

    con = (2-hdist).^h;
    
    %nr of contacts
    contsum = sum(con);
    
    %random number up to sum of all contact strength
    j = contsum.*rand(1,1);
        
    sumarr = 0;  
    for k=1:n
        sumarr = sumarr+con(k);
        if(j<=sumarr)
            j=k;
            break;
        end
    end


end

