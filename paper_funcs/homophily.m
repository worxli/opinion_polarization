%agents
a = 100;

%gleichverteilter meinungsvektor
opvec = linspace(-1,1,a)';

%opinion of fixed agent i
op_i = -1;

%homophilies
homo = 0:2:10;

figure;
PM=[];
for h = homo
    P=[];
    for jj=1:a
        sim(jj)=1-norm(op_i-opvec(jj),1)/2;
    end

    for jj=1:a
        p = sim(jj)^h/sum(sim.^h);
        P = [P,p];
    end
    PM = [PM;P];
end

axis([-1 1 0 0.3]);
plot(opvec,PM);
xlabel('opinion \it o_{j}');
ylabel('probability \it p_{j} \rm that \it j \rm is chosen');
legend('\it h = 0','\it h = 2','\it h = 4','\it h = 6','\it h = 8','\it h = 10');
%title('agent with opinion -1');