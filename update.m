for loop=1:iter
    
    %disp('\niter:');
   %loop
    %%
    %show pointcloud
    %showPointCloud(n, opvec,opinions, 0, 0, 0, pc );

    %%
    %choose the agents
    [i,j]=chooseAgent(n,opvec,opinions,h);
    
    %%
    %show the chosen agents
    %showPointCloud(n, opvec,opinions, i, j, 1, pc )
    
    %%
    %opinion or weight first
    p=rand(1);
    
    if(p>0.5)   
        %weight
        bez = upWeight( i, j, bez, opvec, opinions, pa );
        
        %opinion
        opvec = upOpinion( i, j, bez, opvec, opinions, c );  
        %opvec = degrootOp( i, j, bez, opvec, opinions, c );  
    else  
        %opinion
        opvec = upOpinion( i, j, bez, opvec, opinions, c );
        %opvec = degrootOp( i, j, bez, opvec, opinions, c );
        
        %weight
        bez = upWeight( i, j, bez, opvec, opinions, pa );     
    end
    
    %%
    %show the change of the opinion of the selected agents
    %showPointCloud(n, opvec,opinions, i, j, 0,pc )
    
    %%
    %create data for visualization
    data = createVisData( opvec, loop, step, data );
    
    %%
    diststep = 1;
    
    disp(strcat(strcat(strcat('run: ',num2str(1)), strcat(' h: ',num2str(h))), strcat(' check equilibrium at: ',num2str(loop))));
    %gleichgewichte
    opvec'
        
    %calculate polarization
    if mod(loop,diststep)==0
        %showPointCloud(n, opvec, opinions, 0, 0, 0, 1 );
        %pause(0.1);
        
        pol = calPol(n,opvec, opinions);
        
        poldata = [poldata;pol];
        
        if pol==1 || pol ==0
            disp('Maximale oder minimale Polarisation erreicht!');
            break;
        end
        
         %%
        %gleichgewichte
        gl = calGleichgewichte(n, opvec, bez, opinions, c, pa);
        if(gl==1)
            disp('Gleichgewicht erreicht!');
            break;
        end
        
    end
    
end