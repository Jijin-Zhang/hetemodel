%% 模拟部分   计算2
%（ 1）考虑 稳态可塑性 GH MODEL 上 modelFC 与 data FC的similarity
close all;
clc;clear;
%1 % SC 相同 ms 不同
load('100subparameter_samesc.mat')%%%SC 相同    *5
%%%%%%%%%%%SC 局部归一化 行归一%%%%%%%%%%%%%%%
W=DTI_gunter_100_mean2;
W=abs(W-diag(diag(W)));     %A=A-diag(diag(A));
W2=sum(W,2);
W3=zeros(246,246);
for q=1:246
    W3(q,:)=W2(q,1);
end
SC=W./W3;
%     sum(DTI_gunter,2);
DTI_gunter_100_mean22=SC.*20;%放大20 以匹配 模型
%data 预处理 20subject sc 平均连接
DTI_gunter_meanlink=mean(mean(DTI_gunter_100_mean22))% 0.0813

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%model parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DTI_gunter=DTI_gunter_100_mean22;
figure
subplot(1,3,1)
imagesc(DTI_gunter);
colorbar;
ms=mean(ms_100);% ms mean 一致
subplot(1,3,2)
plot(ms)
FC_DATA_matrix=mean(FC_DATA_matrix_100,3);
subplot(1,3,3)
imagesc(FC_DATA_matrix);
colorbar;
DATA_FC=uptrielement(FC_DATA_matrix);
DATA_FC=DATA_FC';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for  K1=0:14%[0 5 10 14]
    CX=100;
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
                Tm=-K.*(ms-C1)+b(1,t);
                if min(Tm)<0
                    error
                end
                MSsteady_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder1\246neterogeny_mssteady\',num2str(K));
        system(s);
        save(['Numorder1\246neterogeny_mssteady\',num2str(K),'\modeldataSK2.mat'],'DTI_gunter','FC_DATA_matrix','DATA_FC','ms','K','b','model_FC0cell','FCFCsimilarity','ptri1');
    end
end