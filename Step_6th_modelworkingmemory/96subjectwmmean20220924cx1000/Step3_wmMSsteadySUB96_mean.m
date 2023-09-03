%  steady%%%%%%%%%%%%%%%%%%%%%
%考虑 稳态可塑性 GH MODEL 上 modelFC 与SC的similarity1 与 data FC的similarity2
close all;
clc;clear;
%1 wmMS
load('resttowmupdata96subparameter_GLM1.mat');
%model parameters
wmms=mean(wmms_96);%ms mean 是一致
DTI_gunter=mean(DTI_gunter_96,3);

figure
subplot(2,3,1)
imagesc(DTI_gunter.*5);colorbar
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}Brain');title('\fontname{Aria}SC')
set(gca,'FontSize',14);grid on
%%%%%%%%%%%%%%%%
restFC_DATA_matrix=mean(restFC_DATA_matrix_96,3);
restDATA_FC=uptrielement(restFC_DATA_matrix);
restDATA_FC=restDATA_FC';

%%%%%
wmFC_DATA_matrix=mean(wmFC_DATA_matrix_96,3);
wmDATA_FC=uptrielement(wmFC_DATA_matrix);
wmDATA_FC=wmDATA_FC';

%%%%%%%%%%%%%SC 局部归一化 行归一%%%%%%%%%%%%%%%
W=DTI_gunter;
W=abs(W-diag(diag(W)));     %A=A-diag(diag(A));
W2=sum(W,2);
W3=zeros(246,246);
for q=1:246
    W3(q,:)=W2(q,1);
end
SC=W./W3;
sum(SC,2)
DTI_gunter2=SC.*20;
sum(DTI_gunter2,2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%model parameters
DTI_gunter=DTI_gunter2;

% figure
% imagesc(DTI_gunter)
% colorbar
% xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}Brain');title('\fontname{Aria} Steady SC')
% set(gca,'FontSize',14);grid on

subplot(2,3,2)
imagesc(DTI_gunter);colorbar
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}Brain');title('\fontname{Aria}SC_{Steady}')
set(gca,'FontSize',14);grid on
subplot(2,3,3)
plot(wmms)
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}WM MS');
set(gca,'FontSize',14);grid on
subplot(2,3,4)
imagesc(restFC_DATA_matrix);colorbar
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}Brain');title('\fontname{Aria}rest eFC')
set(gca,'FontSize',14);grid on
subplot(2,3,5)
imagesc( wmFC_DATA_matrix);colorbar
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}Brain');title('\fontname{Aria}wm eFC')
set(gca,'FontSize',14);grid on
subplot(2,3,6)
imagesc(wmFC_DATA_matrix-restFC_DATA_matrix);colorbar
title('Wm eFC-Rest eFC')
set(gca,'FontSize',14);grid on

corrcoef(restFC_DATA_matrix(:),wmFC_DATA_matrix(:))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K1=0:21
CX=1000; %重复次数
b=1.4:0.1:3; %基线
C1=mean(wmms);         %% MS均值
ts=61000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model_FC0cell=cell(length(b),CX);

for m=1:1:length(K1)
    K=K1(1,m)
    for j=1:1:CX
        j
        for t = 1:length(b)
            Tm=-K.*(wmms-C1)+b(1,t);
            if min(Tm)<0
                error
            end
            wmMSsteady_MAIN
        end
    end
    %--------------------------------
    s=strcat('mkdir WMNumorder_mean\246neterogeny_wmmssteady\',num2str(K));
    system(s);
    save(['WMNumorder_mean\246neterogeny_wmmssteady\',num2str(K),'\modeldataSK.mat'],'K','b','rFCsFCsimilarity','ptri1','wFCsFCsimilarity','ptri2');
end