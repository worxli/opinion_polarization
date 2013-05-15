function [ pol, cluster, loop, op ] = simpudate( r, n, c, iter, h, opinions, opvec, bez, cont )    
    
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
        diststep=1;
        if mod(loop,diststep)==0
            
            %disp(strcat(strcat(strcat('run: ',num2str(r)), strcat(' h: ',num2str(h))), strcat(' check equilibrium at: ',num2str(loop))));
            %gleichgewichte
            gl = calGleichgewichte(n, opvec, bez, opinions, c);
            if(gl==1)

                %calculate polarization
                
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
                
                %opvec
                %pause( 1)
                %showPointCloud(n, opvec,opinions, 0, 0, 0, 1 );
                %pause(0.5)
                
                %op
                op = sum(sum(opvec))/(n*opinions);

                %cluster
                opvec = unique(opvec,'rows');
                [cluster,~] = size(opvec);


                return
            end
        end
    end
    
    %calculate polarization
            
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
    
    %op
    op = sum(sum(opvec))/(n*opinions);
    
    %cluster
    opvec = unique(opvec,'rows');
    [cluster,~] = size(opvec);