function pointCloud = arrvec( opvec,opinions )

 if(opinions==3)
        pointCloud = opvec';
 elseif (opinions==2)
        pointCloud = [opvec';zeros(1,n)];
 elseif (opinions==1)
        pointCloud = [opvec';zeros(2,n)];
 end

end

