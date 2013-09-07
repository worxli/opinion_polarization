function done = simpudate( r, n, c, iter, h, opinions, opvec, bez, cont, pa )    
    
    %save metadata
    data = struct('agents',n,'a',pa,'homophily',h,'opvec',opvec);
    save(['run-' num2str(r) 'started.mat'],'data');
    
    vector = [];
    
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
        vector = [vector;opvec'];
        
        %%
        if mod(loop,200)==0
           
           save(['run-' num2str(r) '-iteration-' num2str(loop-200+1) 'to' num2str(loop)],'vector');
           vector = []; 
            
        end
        
        if mod(loop,n/2)==0
          
            %gleichgewichte
            gl = calGleichgewichte(n, opvec, bez, opinions, c, pa);
            if(gl==1)
                break
            end
        end
            
    end
    
    %%
    %save data when run finished
    data = struct('opvec',opvec,'iterations',loop);
    save(['run-' num2str(r) 'finished'],'data','vector');

    