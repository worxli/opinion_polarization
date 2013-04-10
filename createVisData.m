function data = createVisData( n, opinions, opvec, loop, step, data)

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

end

