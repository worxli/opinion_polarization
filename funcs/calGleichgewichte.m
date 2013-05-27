function gl = calGleichgewichte(n, opvec, bez, opinions, c, pa)
    
    %temporary veriables
    topvec1 = mvpa(opvec,4);
    topvec2 = mvpa(opvec,4);
    tbez1 = mvpa(bez,4);
    tbez2 = mvpa(bez,4);
    opvec = mvpa(opvec,4);
    
    %first possibility: weight first
    for ii=1:n
        for jj=ii+1:n
            
           	%weight
            tbez1 = upWeight( ii, jj, tbez1, topvec1, opinions, pa);

            %opinion
            topvec1 = upOpinion( ii, jj, tbez1, topvec1, opinions, c );  
            
        end
    end
    
    %see if something has changed, if not the difference should be 0
    topvec = abs(opvec-topvec1);
    tbez = abs(bez-tbez1);
    
    %if matrix and vector are zero try second possibility, otherwise
    %continue iteration because there is no need for a stop
    if((sum(sum(tbez))==0)&(sum(topvec)==0))
        %second possibility: 
        for ii=1:n
            for jj=ii+1:n

                %opinion
                topvec2 = upOpinion( ii, jj, tbez2, topvec2, opinions, c ); 

                %weight
                tbez2 = upWeight( ii, jj, tbez2, topvec2, opinions, pa );

            end
        end
        
        %see if something has changed, if not the difference should be 0
        topvec = abs(opvec-topvec2);
        tbez = abs(bez-tbez2);
        
        if((sum(sum(tbez))==0)&(sum(topvec)==0))
            %gleichgewicht erreicht
            gl=1;
            disp('gleichgewicht');
        else
            %kein gleichgewicht
            gl=0;
        end
        
    else
        %kein gleichgewicht
        gl=0;
    end

end