function [ bez ] = upWeight( i, j, bez, opvec, opinions )
    
    %calculate the weight based on the formula
    diff = norm(opvec(i,:)-opvec(j,:),1);
    
    %set the weigth for both agents simultaneously
    bez(i,j) = 1 - diff/opinions;
    bez(j,i) = 1 - diff/opinions;

end

