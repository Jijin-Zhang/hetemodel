%% （1）未考虑 稳态可塑性 GH MODEL 上 modelFC 与SC的similarity1 与 data FC的similarity2
close all;
clc;clear;
%  SC
%1 wmMS
load('resttowmupdata96subparameter_GLM1.mat');
%model parameters
%%%%   %%%%%%%%%%%%%%%%%%%%%%%%%%
%OUTPUT
wmms=mean(wmms_96);%ms mean 是一致
mean(wmms)
min(wmms)
max(wmms)

restms=mean(restms_96);%ms mean 是一致
mean(restms)
min(restms)
max(restms)
figure
plot(restms,wmms)

[r,p]=corr(restms',wmms') 

DTI_gunter=mean(DTI_gunter_96,3).*5;
%%%%%%%%%%%%%%%%
restFC_DATA_matrix=mean(restFC_DATA_matrix_96,3);
restDATA_FC=uptrielement(restFC_DATA_matrix);
restDATA_FC=restDATA_FC';
%%%%%
wmFC_DATA_matrix=mean(wmFC_DATA_matrix_96,3);
wmDATA_FC=uptrielement(wmFC_DATA_matrix);
wmDATA_FC=wmDATA_FC';
[r1,p1]=corrcoef(DTI_gunter(:),restFC_DATA_matrix(:))
[r2,p2]=corrcoef(wmFC_DATA_matrix(:),DTI_gunter(:))
[r3,p3]=corrcoef(wmFC_DATA_matrix(:),restFC_DATA_matrix(:))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parameter
K1=0:21
b=1.4:0.1:4
CX=1000;  %重复次数
C1=mean(wmms);         %% MS均值
ts=61000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model_FC0cell=cell(length(b),CX);
for m=1:1:length(K1)
    K=K1(1,m)
    for j=1:1:CX
        j
        for t = 1:length(b)
            Tm=-K.*(wmms-C1)+b(1,t).* ones(1, 246);
            if min(Tm)<0
                error
            end
            wmMS_MAIN
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    s=strcat('mkdir WMNumorder_mean\246neterogeny_wmms\',num2str(K));
    system(s);
    save(['WMNumorder_mean\246neterogeny_wmms\',num2str(K),'\modeldataSK.mat'],'K','b','rFCsFCsimilarity','ptri1','wFCsFCsimilarity','ptri2');
end