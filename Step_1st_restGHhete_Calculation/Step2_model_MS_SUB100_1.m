%% Part of simulation
%% Calculation 1
% （1） GH MODEL ,the similarity of model FC and data FC
close all;
clc;clear;
% group level  SC same
%1 MS
load('100subparameter_samesc.mat')
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
% figure
% plot(ms);
% xlabel('Regions')
mean(ms)
max(ms)
min(ms)
std(ms)
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
    CX=1000;  %重复次数
    C1=mean(ms);         %% MS均值
    ts=61000;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    model_FC0cell=cell(length(b),CX);
    stand_matrix=ones(246,246);
    for m=1:1:length(K1)
        K=K1(1,m)
        for j=1:1:CX
            j
            for t = 1:length(b)

                Tm=-K.*(ms-C1)+b(1,t).* ones(1, 246);

                if min(Tm)<0
                    error
                end
                MS_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder1_2\246neterogeny_ms\',num2str(K));
        system(s);
        save(['Numorder1_2\246neterogeny_ms\',num2str(K),'\modeldataSK.mat'],'K','b','FCFCsimilarity','ptri1');
    end
end
clc;clear;close all;
Step3_MS_steadySUB100_1