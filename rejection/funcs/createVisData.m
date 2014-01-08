function data = createVisData( opvec, loop, step, data)
    
    opvec(find(opvec>0.99))=1;
    dat =histc(opvec,-1:step:1)';
    data(:,:,loop) = interp1([-1:step:1]',dat',[-1:step/100:1]')';

end