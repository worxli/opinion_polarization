for loop=1:iter

    %chose random agent -> i
    i = randi(n,1);
    
    %find a contact for the agent -> j
    
    %nr of contacts
    contsum = sum(cont(i,:));
    
    %random number up to sum of all contact strength
    j = contsum.*rand(1,1);
        
    sumarr = 0;  
    for k=1:n
        sumarr = sumarr+cont(i,k);
        if(j<=sumarr)
            j=k;
            break;
        end
    end
    
    %opinion or weight first
    p=rand(1);
    
    if(p>0.5)
        
        %weight
        diff = norm(opvec(i,:)-opvec(j,:),1);
        bez(i,j) = 1 - diff/opinions;
        bez(j,i) = 1 - diff/opinions;
        
        %opinion
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
        
    else
        
        %opinion
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
        
        %weight
        diff = norm(opvec(i,:)-opvec(j,:),1);
        bez(i,j) = 1 - diff/opinions;
        bez(j,i) = 1 - diff/opinions;
        
    end
    
    %create data for visualization
    for l = 1:n
        for op=1:opinions
            ind = 1;
            for st=-1:step:1
               if(opvec(l,op)<=st+step)
                   data(loop,ind,op)=data(loop,ind,op)+1; 
                   break;
               end
               ind = ind+1;
            end
        end      
    end   
    
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
            %break;
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