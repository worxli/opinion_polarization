opvec = -1:0.05:1;
n=length(opvec);
opinions = 1;

for h=0:5

    prob = zeros(n,n);

    for i=1:n

    %sum distances from i to all agents j
        hdist = zeros(n,1);
        for jj=1:n
           hdist(jj,1)=norm(opvec(i)-opvec(jj),1);
        end
        hdist=hdist./(2*opinions);

        %make sure connection values are between 0 and 2 -> use h for strength
        %of homophily, if h=0 -> con=1 for all agents
        con = (2-hdist).^h;

        %sum of all contact strength's
        contsum = sum(con);

        %random number (between 0 and 1) x sum -> random number between 0 and
        %total strenght
        j = contsum.*rand(1,1);

        %find agent which was chosen with the random number
        sumarr = 0;  
        for k=1:n
            sumarr = sumarr+con(k);
            if(j<=sumarr)
                %set j to that agent
                j=k;
                break;
            end
        end

        prob(:,i) = con;

    end

    prob = prob./max(max(prob));
    surf(opvec, opvec, prob);
    colormap(flipud(gray));
    view(20,25);
    grid on;
    axis([-1 1 -1 1 0 1]);
    pause(0.1);
    
end
