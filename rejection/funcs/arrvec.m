function pointCloud = arrvec( n, opvec,opinions )
 
    %arrange vector, so that it can be displayed as a pointcloud
    %make sure it is a 3xN vector
    if(opinions==3)
        pointCloud = opvec';
    elseif (opinions==2)
        pointCloud = [opvec';zeros(1,n)];
    elseif (opinions==1)
        pointCloud = [opvec';zeros(2,n)];
    end

end

