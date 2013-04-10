function [] = showPointCloud( opvec,opinions, i, j, arg )
    
    %check if agents are specified
    if(i~=0&&j~=0)
        %check if before or after update, 0 is after
        if(arg==0)
            pause(0.5);
            pointCloud = arrvec([opvec(i,:);opvec(j,:)],opinions);
            clickA3DPoint(pointCloud,2);
            pause(1);
        else
            pointCloud = arrvec([opvec(i,:);opvec(j,:)],opinions);
            clickA3DPoint(pointCloud,1);
        end
    else
        clf;
        pointCloud = arrvec(opvec,opinions);
        clickA3DPoint(pointCloud,0);
        
        %format graph
        axis([-1 1 -1 1 -1 1]);
        grid on;
        box on;
        view(20,25);
    end

end

