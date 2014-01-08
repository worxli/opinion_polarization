function [i,j] = chooseAgent( arg )

    %retrieve arguments
    n = arg.agents;
    opvec = arg.opvec;
    opinions = arg.opinions;
    h = arg.homophily;
    
    %%
    %chose random agent -> i
    i = randi(n,1);
    
    %sum distances from i to all agents j
    hdist = zeros(n,1);
    for jj=1:n
       hdist(jj,1)=norm(opvec(i)-opvec(jj),1);
    end
    hdist=hdist./(2*opinions);
    
    %make sure connection values are between 0 and 2 -> use h for strength
    %of homophily, if h=0 -> con=1 for all agents
    con = (1-hdist).^h;
    
    %can't choose himself for interaction
    con(i)=0;
    
    %sum of all contact strength's
    contsum = sum(con);
    
    %random number (between 0 and 1) x sum -> random number between 0 and
    %total strenght
    j = contsum.*rand(1,1);
    
    %find agent which was chosen with the random number
    sumarr = 0;  
    for k=1:n
        sumarr = sumarr+con(k);
        if(j<=sumarr)
            %set j to that agent
            j=k;
            break;
        end
    end
    
end

