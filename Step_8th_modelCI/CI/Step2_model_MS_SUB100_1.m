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
% DATA_FC=uptrielement(FC_DATA_matrix);
% DATA_FC=DATA_FC';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parameter
K1=[0]
CX=1;  %重复次数
C1=mean(ms);         %% MS均值
ts=61000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for m=1:1:length(K1)
    K=K1(1,m)
    tic
    %确定工作
    if K==0 || K==2 || K==4 || K==5  %||或
        b=2.8
    end
    if K==1 || K==3 || K==6|| K==7|| K==8
        b=2.9
    end

    if K==9 || K==11
        b=3   %工作点
    end
    if K==10
        b=3.1
    end
    if K==12
        b=3.3   %工作点
    end
    if K==13|| K==14
        b=3.4  %工作点
    end

    for j=1:1:CX
        j
        for t = 1:length(b)
            Tm=-K.*(ms-C1)+b(1,t).* ones(1, 246);

            if min(Tm)<0
                error
            end
            tic
            CI_MAIN
            toc
        end

        %--------------------------------
%         s=strcat('mkdir MODEL\246CI\',num2str(K),'\CX',num2str(j));
%         system(s);
%         save(['MODEL\246CI\',num2str(K),'\CX',num2str(j),'\modeldataCI.mat'],'K','b','kop','MS','SE','CI_model');
    end
end
% clc;clear;close all;
% Step3_MS_steadySUB100_1