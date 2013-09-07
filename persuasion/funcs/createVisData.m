function data = createVisData( opvec, loop, step, data)

    data(:,:,loop)=histc(opvec,-1:step:1)';

end