opvec = [-1:0.1:1]';

pa=1:10;

for a=pa 
    W = [];
    bez = zeros(length(opvec));


    for i = 1:length(opvec)

       R=[];
       for j = 1:length(opvec)
           tmp = upWeight(i,j,bez,opvec,1,a);
           R=[R,tmp(i,j)];
       end
       W = [W; R];
    end

    surf(opvec,opvec,W);
    pause(0.5);
end