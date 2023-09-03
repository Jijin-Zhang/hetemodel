%% 模拟部分   计算1
% 异质性 GH model  模拟 BOLD 信号     进而 求 脑网络  的FC matrix
% SC bu同 ms 不同
close all;
clc;clear;
load('resttowmupdata96subparameter_GLM1.mat')

for sub=1:96
    tic
    sub
    ms=wmms_96(sub,:);%ms mean 是一致

    DTI_gunter2=DTI_gunter_96(:,:,sub);
    %%%%%%%%%%%SC 局部归一化 行归一%%%%%%%%%%%%%%%
    W=DTI_gunter2;
    W=abs(W-diag(diag(W)));     %A=A-diag(diag(A));
    W2=sum(W,2);
    W3=zeros(246,246);
    for q=1:246
        W3(q,:)=W2(q,1);
    end
    SC=W./W3;
    %     sum(DTI_gunter,2);
    DTI_gunter=SC.*20;%放大20 以匹配 模型
    %data 预处理 20subject sc 平均连接
    DTI_gunter_meanlink=mean(mean(DTI_gunter));% 0.0813
    sum(DTI_gunter,2);
    % figure(1)
    % imagesc(DTI_gunter);
    % colorbar
    % pause(0.5)


    restFC_DATA_matrix2=restFC_DATA_matrix_96(:,:,sub);
    restDATA_FC=uptrielement(restFC_DATA_matrix2);
    restDATA_FC=restDATA_FC';

    wmFC_DATA_matrix2=wmFC_DATA_matrix_96(:,:,sub);
    wmDATA_FC=uptrielement(wmFC_DATA_matrix2);
    wmDATA_FC=wmDATA_FC';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %parameter
    b=[1.4:0.1:3];
    CX=50;  %重复次数
    C1=mean(ms);         %% MS均值
    K1=0:3:6;
    %     K1=fix(1.4./max(ms-C1))
    %     k2(sub,1)=K1;%min(k2) 7

    ts=61000;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    model_FC0cell=cell(length(b),CX);
    for m=1:1:length(K1)
        K=K1(1,m)

        for j=1:1:CX
            j
            for t = 1:length(b)
                t
                Tm=-K.*(ms-C1)+b(1,t).* ones(1, 246);
                if min(Tm)<0
                    error
                end
                wmMSsteady_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_wmmssteady\',num2str(K));
        system(s);
        save(['Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_wmmssteady\',num2str(K),'\modeldataSK.mat'],'K','b','model_FC0cell','rFCsFCsimilarity','ptri1','wFCsFCsimilarity','ptri2');
    end
end
toc
