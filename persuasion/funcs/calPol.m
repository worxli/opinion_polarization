function pol = calPol( n, opvec, opinions )

    %calculate distance matrix
    dist = zeros(n,n);

    for ii=1:n
        for jj=1:n
            dist(ii,jj) = norm(opvec(ii,:)-opvec(jj,:),1)/(opinions);
        end
    end

    %average distance
    avdist = sum(sum(dist))/(n*n);
    pol = 0;

    %calculate polarization
    for ii=1:n
        for jj=ii:n
            pol=pol+(avdist-dist(ii,jj))^2;
        end
    end

    pol = pol*2/(n*n+n);
    
end

