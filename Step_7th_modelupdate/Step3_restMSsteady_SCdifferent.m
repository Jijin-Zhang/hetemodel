%% 模拟部分
%（ 1）考虑 稳态可塑性 GH MODEL 上 modelFC 与 data FC的similarity
close all;
clc;clear;
%1 % SC 不同 ms 不同
load('resttowmupdata96subparameter_GLM1.mat','restms_96','restse_96', 'restms_96subject','DTI_gunter_96','DTI_gunter_sub','restFC_DATA_matrix_96','restFC_DATA_sub','restDATA_FC_uptri');
%model parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for sub=1:96
    ms=restms_96(sub,:);
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
    DTI_gunter_meanlink=mean(mean(DTI_gunter))% 0.0813
    % figure(1)
    % imagesc(DTI_gunter);
    % colorbar
    % pause(0.5)
    restFC_DATA_matrix2=restFC_DATA_matrix_96(:,:,sub);
    DATA_FC=uptrielement(restFC_DATA_matrix2);
    DATA_FC=DATA_FC';

    DATA_FC2=restDATA_FC_uptri{sub,1};
    if DATA_FC==DATA_FC2
        'noerror'
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    CX=50;
    b=[1.4:0.1:3];
    C1=mean(ms);
    K1=0:3:6;
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
                restMSsteady_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_restmssteady\',num2str(K));
        system(s);
        save(['Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_restmssteady\',num2str(K),'\modeldataSK.mat'],'ms','K','b','model_FC0cell','FCFCsimilarity','ptri1');
    end
end