function data = createVisData( opvec, loop, step, data)
    
%{
    %for all agents
    for l = 1:n
        %for all opinions
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
    
    data(1,:,:)
  %}  

    data(:,:,loop)=histc(opvec,-1:step:1)';

end