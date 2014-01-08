clear all;

%% parameters
homophily=0:0.5:10;
runs=1:5;
agent=[10,20,50,100];
a=1.5;

%%

%%foldername

hhhpol=[];
ind = 0;

for agents = agent
    
    ind = ind + 1;
    
    hhpol=[];

    for i=1:2

        if i==2
            foldername = ['persuasion/' 'ag' num2str(agents) ''];
        else
            foldername = ['rejection/' 'ag' num2str(agents) ''];
        end

        hpol = [];

        for h=homophily

            pol = [];

            for r=runs

                %%filename
                if i==2
                    filename = ['h' num2str(h) '-run-' num2str(r) '.mat'];
                else
                    filename = ['h' num2str(h) '-a-' num2str(a) '-run-' num2str(r) '.mat'];
                end

                if exist([foldername '/' filename], 'file')

                    mat = load([foldername '/' filename]);
                    if ismember('arg_end', fieldnames(mat))

                        arg_end = load([foldername '/' filename],'arg_end');
                        arg_end = arg_end.arg_end;

                        pol = [pol;arg_end.pol];
                        %opvec = arg_end.opvec;

                    end
                else
                    disp([foldername '/' filename]);
                end

            end

            l=length(pol);
            if l<50
                agents
                h
                l
                a
            end


            pol = [pol;zeros(50-length(pol),1)];

            hpol = [hpol,pol];

        end
        hhpol = [hhpol,hpol];

    end
    
    %arg.pol = hhpol;
    %visualp(arg);
    
    hhhpol(:,:,ind) = hhpol;
    
end

arg.pol = hhhpol;
visualp(arg);

