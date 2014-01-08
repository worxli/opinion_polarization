
addpath funcs;
aa = 1:0.25:1.5;
opvec = (-1:0.1:1)';
n=length(opvec);

for a=aa
    
   mat=zeros(n);
   for i=1:n
       for j=1:n
           
           bez = upWeight(i, j, zeros(n), opvec, 1, a);
           %mat(i,j)=bez(i,j);
           if bez(i,j)<=0
               mat(i,j)=abs(opvec(i)-opvec(j));
           end
           
       end
   end
   
   figure;
   surf(opvec, opvec, mat);
       
       
    
end