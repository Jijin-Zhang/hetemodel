%% Part of simulation
%% Calculation 3
close all;
clc;clear;
load('100subparameter_samesc.mat')
% 100subject sc
figure
subplot(1,3,1)
imagesc(DTI_gunter_100_mean2);
colorbar;
title('eSC mean')
mean(mean(DTI_gunter_100_mean2))%0.1369
%%%    %%%%%%%%%%%%%%%%%%%%%%%%%%%
%model parameters
%%%%   %%%%%%%%%%%%%%%%%%%%%%%%%%
DTI_gunter=DTI_gunter_100_mean2;
ms=mean(ms_100);
mean(ms);std(ms);
subplot(1,3,2)
plot(ms)
FC_DATA_matrix=mean(FC_DATA_matrix_100,3);
subplot(1,3,3)
imagesc(FC_DATA_matrix)

DATA_FC=uptrielement(FC_DATA_matrix);
DATA_FC=DATA_FC';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parameter
for K1=0:14
    tic
    b=2:0.1:4;
    CX=1000; 
    ts=61000;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    model_FC0cell=cell(length(b),CX);
    stand_matrix=ones(246,246);
    for m=1:1:length(K1)
        K=K1(1,m)
        for j=1:1:CX
            j
            %%%%%%%%%%%%%%%%%%%%ms permute
            rand_index = randperm(246);
            draw_rand_index = rand_index(1:246);
            ms_rand=ms(draw_rand_index);
            ms=ms_rand;
            C1=mean(ms);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            for t = 1:length(b)
                Tm=-K.*(ms-C1)+b(1,t).* ones(1, 246);
                if min(Tm)<0
                    error
                end
                MS_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder1_2\246neterogeny_mspermute\',num2str(K));
        system(s);
        save(['Numorder1_2\246neterogeny_mspermute\',num2str(K),'\modeldataSK.mat'],'K','b','FCFCsimilarity','ptri1');
    end
end
toc

close all;
clc;clear;
Step5_MSpermute_SUB100_steady
