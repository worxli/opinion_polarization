    function [ bez ] = upWeight( i, j, bez, opvec, opinions ,a )
    
    %calculate the weight based on the formula
    diff = norm(opvec(i,:)-opvec(j,:),1);
    
    %set the weigth for both agents simultaneously
    tbez = 1 - diff/opinions;
    
    bez(i,j) = tbez;
    bez(j,i) = tbez;
    
    end


