for loop=1:iter
    
    %%
    %show pointcloud
    if(pc)
        showPointCloud( opvec,opinions, 0, 0, 0 );
    end

    %%
    %choose the agents
    [i,j]=chooseAgent(n,opvec,opinions,h);
    
    %%
    %show the chosen agents
    if(pc)
        showPointCloud( opvec,opinions, i, j, 1 )
    end
    
    %%
    %opinion or weight first
    p=rand(1);
    
    if(p>0.5)   
        %weight
        bez = upWeight( i, j, bez, opvec, opinions );
        
        %opinion
        opvec = upOpinion( i, j, bez, opvec, opinions, c );  
    else  
        %opinion
        opvec = upOpinion( i, j, bez, opvec, opinions, c );
        
        %weight
        bez = upWeight( i, j, bez, opvec, opinions );     
    end
    
    %%
    %show the change of the opinion of the selected agents
    if(pc)
        showPointCloud( opvec,opinions, i, j, 0 )
    end
    
    %%
    %create data for visualization
    data = createVisData( n, opinions, opvec, loop, step, data );
    
    %%
    %calculate polarization
    if mod(loop,diststep)==0
        %calculate distance matrix
        dist = zeros(n,n);
        
        for ii=1:n
            for jj=ii:n
                dist(ii,jj) = norm(opvec(ii,:)-opvec(jj,:),1)/(opinions);
            end
        end
        
        %average distance
        avdist = sum(sum(dist))*2/(n*n-n);
        pol = 0;
        
        %calculate polarization
        for ii=1:n
            for jj=ii:n
                pol=pol+(avdist-1/(2*opinions)*norm(dist(ii,jj),1))^2;
            end
        end
        
        pol = pol*2/(n*n+n);
        poldata = [poldata;pol];
        
        if pol==1 || pol ==0
            disp('Maximale oder minimale Polarisation erreicht!');
            break;
        end
        
    end
    
    %%
    %gleichgewichte
    if mod(loop,3*diststep)==0
        pol=0;
        for ii=1:n
            for jj=ii+1:n
                diff = norm(opvec(ii,:)-opvec(jj,:),1);             
                pol = pol + bez(ii,jj)- (1 - diff/opinions);
            end
        end
        
        if pol == 0
            disp('Gleichgewicht erreicht!');
            break; 
        end
    end
    
end