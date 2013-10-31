function data = createVisData( opvec, loop, step, data)
    
    opvec(find(opvec>0.99999))=1;
    data(:,:,loop)=histc(opvec,-1:step:1)';

end