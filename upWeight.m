function [ bez ] = upWeight( i, j, bez, opvec, opinions )

    diff = norm(opvec(i,:)-opvec(j,:),1);
    bez(i,j) = 1 - diff/opinions;
    bez(j,i) = 1 - diff/opinions;

end

