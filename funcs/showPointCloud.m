function [] = showPointCloud(n, opvec,opinions, i, j, arg, pc )
    
    if(pc)
        %check if agents are specified
        if(i~=0&&j~=0)
            %check if before or after update, 0 is after
            if(arg==0)
                %wait and the show the new position
                pause(0.1);
                pointCloud = arrvec(2,[opvec(i,:);opvec(j,:)],opinions);
                clickA3DPoint(pointCloud,2);
                pause(0.1);
            else
                %show the two selected agents
                pointCloud = arrvec(2,[opvec(i,:);opvec(j,:)],opinions);
                clickA3DPoint(pointCloud,1);
            end
        else
            %clear window and plot all agents
            clf;
            pointCloud = arrvec(n,opvec,opinions);
            clickA3DPoint(pointCloud,0);

            %format graph
            axis([-1 1 -1 1 -1 1]);
            grid on;
            box on;
            view(20,25);
        end
    end
    
end

