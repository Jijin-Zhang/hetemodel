%% Part of simulation
%% Calculation 2
%£¨ 1£©Homeostatic principle; the similarity of modelFC and data FC
close all;
clc;clear;
%1
load('100subparameter_samesc.mat')
%%%%%%%%%%%SC row normalization
W=DTI_gunter_100_mean2;
W=abs(W-diag(diag(W)));
W2=sum(W,2);
W3=zeros(246,246);
for q=1:246
    W3(q,:)=W2(q,1);
end
SC=W./W3;
sum(SC,2);
DTI_gunter_100_mean22=SC.*20;
DTI_gunter_meanlink=mean(mean(DTI_gunter_100_mean22))% 0.0813

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%model parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DTI_gunter=DTI_gunter_100_mean22;
figure
subplot(1,3,1)
imagesc(DTI_gunter);
colorbar;
ms=mean(ms_100);
subplot(1,3,2)
plot(ms)
FC_DATA_matrix=mean(FC_DATA_matrix_100,3);
subplot(1,3,3)
imagesc(FC_DATA_matrix);
colorbar;
DATA_FC=uptrielement(FC_DATA_matrix);
DATA_FC=DATA_FC';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for  K1=0:14
    CX=1000;
    b=[1.4:0.1:3];
    C1=mean(ms);
    ts=61000;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    model_FC0cell=cell(length(b),CX);
    stand_matrix=ones(246,246);
    %%%%%%%%%%%%%%%%%%%%%%%%
    for m=1:1:length(K1)
        K=K1(1,m)
        for j=1:1:CX
            j
            for t = 1:length(b)
                Tm=-K.*(ms-C1)+b(1,t).* ones(1, 246);
                if min(Tm)<0
                    error
                end
                MSsteady_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder1_2\246neterogeny_mssteady\',num2str(K));
        system(s);
        save(['Numorder1_2\246neterogeny_mssteady\',num2str(K),'\modeldataSK.mat'],'K','b','FCFCsimilarity','ptri1');
    end
end