function [ pol, cluster, loop, op ] = simpudate( r, n, c, iter, h, opinions, opvec, bez, cont, pa )    
    
    %showPointCloud(n, opvec,opinions, 0, 0, 0, 1 );
    
    for loop=1:iter

        %%
        %choose the agents
        [i,j]=chooseAgent(n,opvec,opinions,h);

        %%
        %opinion or weight first
        p=rand(1);

        if(p>0.5)   
            %weight
            bez = upWeight( i, j, bez, opvec, opinions, pa );

            %opinion
            opvec = upOpinion( i, j, bez, opvec, opinions, c );  
        else  
            %opinion
            opvec = upOpinion( i, j, bez, opvec, opinions, c );

            %weight
            bez = upWeight( i, j, bez, opvec, opinions, pa );     
        end

        %%
        %{
        if(loop<500)
            diststep=50;
        elseif(loop<5000)
            diststep=250;
        elseif(loop<10000)
            diststep=1000;
        elseif(loop<100000)
            diststep=5000;
        elseif(loop<1000000)
            diststep=50000;
        else
            diststep=500000;
        end
        %diststep=5000;
        if mod(loop,diststep)==0
            
            disp(strcat(strcat(strcat('run: ',num2str(r)), strcat(' h: ',num2str(h))), strcat(' check equilibrium at: ',num2str(loop))));
            %gleichgewichte
            gl = calGleichgewichte(n, opvec, bez, opinions, c, pa);
            if(gl==1)
                  
                %opvec
                %pause( 1)
                %showPointCloud(n, opvec,opinions, 0, 0, 0, 1 );
                %pause(0.5)
                
                %get loop data
                [ pol, op, cluster] = simData(n, opvec, opinions  )


                return
            end
        end
        
        %}
        %disp(strcat(strcat(strcat('run: ',num2str(r)), strcat(' h: ',num2str(h))), strcat(' check equilibrium at: ',num2str(loop))));
        %gleichgewichte
        gl = calGleichgewichte(n, opvec, bez, opinions, c, pa);
        if(gl==1)
            
            %get loop data
            [ pol, op, cluster] = simData(n, opvec, opinions  );
            
            return
        end
            
    end
    
    %get loop data, only if loop at end -> ca. 10^10 iterations
    [ pol, op, cluster] = simData(n, opvec, opinions  )
    
    