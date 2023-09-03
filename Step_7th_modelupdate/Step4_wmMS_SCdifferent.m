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

    DTI_gunter=DTI_gunter_96(:,:,sub);
    DTI_gunter=DTI_gunter.*5;

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
    CX=50;
    C1=mean(ms);
    K1=0:3:6
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
                wmMS_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_wmms\',num2str(K));
        system(s);
        save(['Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_wmms\',num2str(K),'\modeldataSK.mat'],'K','b','model_FC0cell','rFCsFCsimilarity','ptri1','wFCsFCsimilarity','ptri2');
    end
end
toc