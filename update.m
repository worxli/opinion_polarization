for loop=1:iter
    
    %%
    %show pointcloud
    showPointCloud(n, opvec,opinions, 0, 0, 0, pc );

    %%
    %choose the agents
    [i,j]=chooseAgent(n,opvec,opinions,h);
    
    %%
    %show the chosen agents
    showPointCloud(n, opvec,opinions, i, j, 1, pc )
    
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
    showPointCloud(n, opvec,opinions, i, j, 0,pc )
    
    %%
    %create data for visualization
    data = createVisData( opvec, loop, step, data );
    
    %%
    %calculate polarization
    if mod(loop,diststep)==0
        %showPointCloud(n, opvec, opinions, 0, 0, 0, 1 );
        %pause(0.1);
        
        %calculate distance matrix
        dist = zeros(n,n);
        
        for ii=1:n
            for jj=1:n
                dist(ii,jj) = norm(opvec(ii,:)-opvec(jj,:),1)/(opinions);
            end
        end
        
        %average distance
        avdist = sum(sum(dist))/(n*n);
        pol = 0;
        
        %calculate polarization
        for ii=1:n
            for jj=ii:n
                pol=pol+(avdist-norm(dist(ii,jj),1)/opinions)^2;
            end
        end
        
        pol = pol*2/(n*n+n);
        poldata = [poldata;pol];
        
        if pol==1 || pol ==0
            disp('Maximale oder minimale Polarisation erreicht!');
            break;
        end
        
         %%
        %gleichgewichte
        gl = calGleichgewichte(n, opvec, bez, opinions, c);
        if(gl==1)
            disp('Gleichgewicht erreicht!');
            break;
        end
        
    end
   
    
   
    
end