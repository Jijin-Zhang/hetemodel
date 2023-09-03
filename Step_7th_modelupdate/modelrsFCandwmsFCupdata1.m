%%  SC不同  MS不同   model rest  sFC 和wm sFC  updata 与认知的关系
%1 非稳态 K=0
close all;
clc;clear;
%1% SC 不 同 ms 不同
% load('resttowmupdata96subparameter_GLM1.mat','restms_96','restse_96', 'restms_96subject','wmms_96','wmse_96', 'wmms_96subject','DTI_gunter_96','DTI_gunter_sub','restFC_DATA_matrix_96','restFC_DATA_sub','restDATA_FC_uptri','wmFC_DATA_matrix_96','WM_FC_DATA_sub','wmDATA_FC_uptri');
% for sub=1:96
%     ms=restms_96(sub,:);
%     b=[1.4:0.1:3];
%     C1=mean(ms);
%     K1=fix(1.4./max(ms-C1))
%     krest(sub,1)=K1;
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load('resttowmupdata96subparameter_GLM1.mat','restms_96','restse_96', 'restms_96subject','wmms_96','wmse_96', 'wmms_96subject','DTI_gunter_96','DTI_gunter_sub','restFC_DATA_matrix_96','restFC_DATA_sub','restDATA_FC_uptri','wmFC_DATA_matrix_96','WM_FC_DATA_sub','wmDATA_FC_uptri');
% for sub=1:96
%     ms=wmms_96(sub,:);%ms mean 是一致
%     C1=mean(ms);         %% MS均值
%     K1=fix(1.4./max(ms-C1))
%     kwm(sub,1)=K1;
% end

tic
for K=3%[0 3 6]

for sub=1:10
    sub
    %model  rest
     %K=krest(sub,1);
    
    load(['Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_restms\',num2str(K),'\modeldataSK.mat'])
    %----检查 结果
    fcsim1=mean(FCFCsimilarity,2)';
    fcsims1=std(FCFCsimilarity');
    sub100_sim(sub,:)=fcsim1;
    [sim binx]=max(fcsim1);
    Tsim(1,sub)=b(binx);
    Tsim(2,sub)=sim;%均值后 peak
    Tsim(3,sub)= fcsims1(binx);% peak 的 标准差
    for CX=1:50
        restmodel_FC(:,:,CX)=model_FC0cell{binx,CX};
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear model_FC0cell  fcsim1 binx sim
      %K2= kwm(sub,1)
   
    load(['Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_wmms\',num2str(K),'\modeldataSK.mat'])
    %----检查 结果
    fcsim1=mean(wFCsFCsimilarity,2)';
    [sim binx]=max(fcsim1);
    Tsim2(1,sub)=b(binx);
    Tsim2(2,sub)=sim;%均值后 peak
    for CX=1:50
        WMmodel_FC(:,:,CX)=model_FC0cell{binx,CX};
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for CX=1:50
        rest_sFC=restmodel_FC(:,:,CX);
        [rest_vector1]=uptrielement(rest_sFC);
        WM_sFC=WMmodel_FC(:,:,CX);
        [WM_vector1]=uptrielement(WM_sFC);
        UPDATA_rsFCwmsFC(CX)=corr(rest_vector1',WM_vector1');
    end
    UPDATA_rsFCwmsFC_model1(sub,1)=mean(UPDATA_rsFCwmsFC);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rest_sFC2=mean(restmodel_FC,3);
    [rest_vector2]=uptrielement(rest_sFC2);
    WM_sFC2=mean(WMmodel_FC,3);
    [WM_vector2]=uptrielement(WM_sFC2);
    UPDATA_rsFCwmsFC_model2(sub,1)=corr(rest_vector2',WM_vector2');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% s=strcat('mkdir modelrsFCtowmsFC_updata\SC_different\',num2str(K));
% system(s);
% save(['modelrsFCtowmsFC_updata\SC_different\',num2str(K),'\subSCdifferentrsFCwmsFCupdata.mat'],'UPDATA_rsFCwmsFC_model1','UPDATA_rsFCwmsFC_model2');
end
toc
%%  K=0
clc;clear;close all;
load(['modelrsFCtowmsFC_updata\SC_different\0\subSCdifferentrsFCwmsFCupdata.mat']);
load('WorkingmemoryACCURACY.mat')
sub1=1
sub=96
WorkingmemoryACCURACY=WorkingmemoryACCURACY(sub1:sub,1);
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
[r1,p1]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1)
[r2,p2]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC2)
figure
set(gcf,'color','w'); % 背景设为白色
plot(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC2,'.k',MarkerSize=18)
% text(-3,0.66,'r=0.1538 p=0.1348','FontSize',14);
text(-3,0.2,'r=-0.0134 p=0.8965','FontName','Arial','FontSize',18);
set(gca,'xtick',(-4:1:2),'ytick',(0.2:.1:0.5))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
xlim([-4 2]);ylim([0.15 0.52]);
% Label axes
xlabel( 'Accuracy', 'Interpreter', 'none' );
ylabel( 'Similarity_model', 'Interpreter', 'none' );
title('96subject Model SC different k=0')
set(gca,'FontName','Arial','FontSize',14)
grid on
%% load('Workingmemoryfen.mat')
% sub1=1
% sub=96 
% Workingmemory=Workingmemory(sub1:sub,1);
% Workingmemory=normalize(Workingmemory);
% UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
% UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
% % Workingmemory=normalize(Workingmemory);
% [r1,p1]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC1)
% [r2,p2]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC2)
% figure
% set(gcf,'color','w'); % 背景设为白色
% plot(Workingmemory, UPDATA_rsFCwmsFC1,'.k','markersize',18)
% text(-3,0.52,'r=0.0389 p=0.6249','FontSize',14);
% xlabel( 'Workingmemory', 'Interpreter', 'none' );
% ylabel( 'Similarity', 'Interpreter', 'none' );
% title('96subject Model SC same  Homeostatic k=6')
% grid on
% set(gca,'FontSize',14);
%
load('resttowmupdata96subparameter_GLM1.mat');
if restFC_DATA_sub==WM_FC_DATA_sub
    'no error'
end
i=0;
for sub=1:96
    i=i+1;
    rFC=restFC_DATA_matrix_96(:,:,sub);
    rest_vector1=uptrielement(rFC);
    wFC=wmFC_DATA_matrix_96(:,:,sub);
    wm_vector1=uptrielement(wFC);
    [resttowm_updata2,p2]=corrcoef(rest_vector1',wm_vector1');
    resttowm_updata1(i,1)=resttowm_updata2(1,2);
    p2(i,1)=p2(1,2);
end
i=0;
for sub=1:96
    i=i+1;
    rest_vector1= restDATA_FC_uptri{sub};
    wm_vector1=wmDATA_FC_uptri{sub};
    [resttowm_updata3,p3]=corrcoef(rest_vector1,wm_vector1);
    resttowm_updata4(i,1)=resttowm_updata3(1,2);
    p2(i,1)=p3(1,2);
end
load('WorkingmemoryACCURACY.mat','WorkingmemoryACCURACY','WorkingmemoryACCURACY_subject')
if  WorkingmemoryACCURACY_subject==restFC_DATA_sub;
    'no error'
end
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)

[r2,p2]=corrcoef(UPDATA_rsFCwmsFC2,resttowm_updata4)
figure
set(gcf,'color','w'); % 背景设为白色
plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)
text(0.3,0.75,'r=-0.3077 p=0.0023 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.2:0.1:0.5),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.15 0.52]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_model', 'Interpreter', 'none' );
ylabel( 'Similarity_data', 'Interpreter', 'none' );
title('96subject Working memory')
grid on
%%  K=6
clc;clear;close all;
load(['modelrsFCtowmsFC_updata\SC_different\6\subSCdifferentrsFCwmsFCupdata.mat']);
load('WorkingmemoryACCURACY.mat')
sub1=1
sub=96
WorkingmemoryACCURACY=WorkingmemoryACCURACY(sub1:sub,1);
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
[r1,p1]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1)
[r2,p2]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC2)
figure
set(gcf,'color','w'); % 背景设为白色
plot(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1,'.k',MarkerSize=18)
% text(-3,0.66,'r=0.1538 p=0.1348','FontSize',14);
text(-3,0.3,'r=-0.0395 p=0.7026','FontName','Arial','FontSize',18);
set(gca,'xtick',(-4:1:2),'ytick',(0.15:.05:0.7))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
xlim([-4 2]);ylim([0.2 0.5]);
% Label axes
xlabel( 'Accuracy', 'Interpreter', 'none' );
ylabel( 'Similarity_model', 'Interpreter', 'none' );
title('96subject Model SC different k=6')
set(gca,'FontName','Arial','FontSize',14)
grid on
%% load('Workingmemoryfen.mat')
% sub1=1
% sub=96 
% Workingmemory=Workingmemory(sub1:sub,1);
% Workingmemory=normalize(Workingmemory);
% UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
% UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
% % Workingmemory=normalize(Workingmemory);
% [r1,p1]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC1)
% [r2,p2]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC2)
% figure
% set(gcf,'color','w'); % 背景设为白色
% plot(Workingmemory, UPDATA_rsFCwmsFC1,'.k','markersize',18)
% text(-3,0.52,'r=0.0389 p=0.6249','FontSize',14);
% xlabel( 'Workingmemory', 'Interpreter', 'none' );
% ylabel( 'Similarity', 'Interpreter', 'none' );
% title('96subject Model SC same  Homeostatic k=6')
% grid on
% set(gca,'FontSize',14);
%
load('resttowmupdata96subparameter_GLM1.mat');
if restFC_DATA_sub==WM_FC_DATA_sub
    'no error'
end
i=0;
for sub=1:96
    i=i+1;
    rFC=restFC_DATA_matrix_96(:,:,sub);
    rest_vector1=uptrielement(rFC);
    wFC=wmFC_DATA_matrix_96(:,:,sub);
    wm_vector1=uptrielement(wFC);
    [resttowm_updata2,p2]=corrcoef(rest_vector1',wm_vector1');
    resttowm_updata1(i,1)=resttowm_updata2(1,2);
    p2(i,1)=p2(1,2);
end
i=0;
for sub=1:96
    i=i+1;
    rest_vector1= restDATA_FC_uptri{sub};
    wm_vector1=wmDATA_FC_uptri{sub};
    [resttowm_updata3,p3]=corrcoef(rest_vector1,wm_vector1);
    resttowm_updata4(i,1)=resttowm_updata3(1,2);
    p2(i,1)=p3(1,2);
end
load('WorkingmemoryACCURACY.mat','WorkingmemoryACCURACY','WorkingmemoryACCURACY_subject')
if  WorkingmemoryACCURACY_subject==restFC_DATA_sub;
    'no error'
end
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)

[r2,p2]=corrcoef(UPDATA_rsFCwmsFC2,resttowm_updata4)
figure
set(gcf,'color','w'); % 背景设为白色
plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)
text(0.2,0.5,'r=-0.2614 p=0.0101 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.2:0.1:0.5),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.15 0.5]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_model', 'Interpreter', 'none' );
ylabel( 'Similarity_data', 'Interpreter', 'none' );
title('96subject Working memory')
grid on
%%


%%稳态 K=3
close all;
clc;clear;
%1% SC 不 同 ms 不同
% load('resttowmupdata96subparameter_GLM1.mat','restms_96','restse_96', 'restms_96subject','wmms_96','wmse_96', 'wmms_96subject','DTI_gunter_96','DTI_gunter_sub','restFC_DATA_matrix_96','restFC_DATA_sub','restDATA_FC_uptri','wmFC_DATA_matrix_96','WM_FC_DATA_sub','wmDATA_FC_uptri');
% for sub=1:96
%     ms=restms_96(sub,:);
%     b=[1.4:0.1:3];
%     C1=mean(ms);
%     K1=fix(1.4./max(ms-C1))
%     krest(sub,1)=K1;
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load('resttowmupdata96subparameter_GLM1.mat','restms_96','restse_96', 'restms_96subject','wmms_96','wmse_96', 'wmms_96subject','DTI_gunter_96','DTI_gunter_sub','restFC_DATA_matrix_96','restFC_DATA_sub','restDATA_FC_uptri','wmFC_DATA_matrix_96','WM_FC_DATA_sub','wmDATA_FC_uptri');
% for sub=1:96
%     ms=wmms_96(sub,:);%ms mean 是一致
%     C1=mean(ms);         %% MS均值
%     K1=fix(1.4./max(ms-C1))
%     kwm(sub,1)=K1;
% end

tic
for K=3%[0 3 6]
    K
for sub=1:96
    sub
    %model  rest
      %K=krest(sub,1);
    load(['Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_restmssteady\',num2str(K),'\modeldataSK.mat'])
    %----检查 结果
    fcsim1=mean(FCFCsimilarity,2)';
    fcsims1=std(FCFCsimilarity');
    sub100_sim(sub,:)=fcsim1;
    [sim binx]=max(fcsim1);
    Tsim(1,sub)=b(binx);
    Tsim(2,sub)=sim;%均值后 peak
    Tsim(3,sub)= fcsims1(binx);% peak 的 标准差
    for CX=1:50
        restmodel_FC(:,:,CX)=model_FC0cell{binx,CX};
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear model_FC0cell  fcsim1 binx sim Tsim
    %  K2= kwm(sub,1);
    load(['Numorder_SCdifferent\sub',num2str(sub),'\246neterogeny_wmmssteady\',num2str(K),'\modeldataSK.mat'])
    %----检查 结果
    fcsim1=mean(wFCsFCsimilarity,2)';
    [sim binx]=max(fcsim1);
    Tsim(1,sub)=b(binx);
    Tsim(2,sub)=sim;%均值后 peak
    for CX=1:50
        WMmodel_FC(:,:,CX)=model_FC0cell{binx,CX};
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for CX=1:50
        rest_sFC=restmodel_FC(:,:,CX);
        [rest_vector1]=uptrielement(rest_sFC);
        WM_sFC=WMmodel_FC(:,:,CX);
        [WM_vector1]=uptrielement(WM_sFC);
        UPDATA_rsFCwmsFC(CX)=corr(rest_vector1',WM_vector1');
    end
    UPDATA_rsFCwmsFC_model1(sub,1)=mean(UPDATA_rsFCwmsFC);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rest_sFC2=mean(restmodel_FC,3);
    [rest_vector2]=uptrielement(rest_sFC2);
    WM_sFC2=mean(WMmodel_FC,3);
    [WM_vector2]=uptrielement(WM_sFC2);
    UPDATA_rsFCwmsFC_model2(sub,1)=corr(rest_vector2',WM_vector2');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=strcat('mkdir modelrsFCtowmsFC_updata\SC_different\Homeostatic\',num2str(K))
system(s);
save(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\',num2str(K),'\subSCdifferentrsFCwmsFCupdata.mat'],'UPDATA_rsFCwmsFC_model1','UPDATA_rsFCwmsFC_model2');
end
toc


%%  K=0
clc;clear;close all;
load(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\0\subSCdifferentrsFCwmsFCupdata.mat']);
load('WorkingmemoryACCURACY.mat')
sub1=1
sub=96
WorkingmemoryACCURACY=WorkingmemoryACCURACY(sub1:sub,1);
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
[r1,p1]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1)
[r2,p2]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC2)
figure
set(gcf,'color','w'); % 背景设为白色
plot(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1,'.k',MarkerSize=18)
% text(-3,0.66,'r=0.1538 p=0.1348','FontSize',14);
text(-3,0.68,'r=-0.0553 p=0.5929','FontName','Arial','FontSize',18);
set(gca,'xtick',(-4:1:2),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
xlim([-4 2]);ylim([0.4 0.75]);
% Label axes
xlabel( 'Accuracy', 'Interpreter', 'none' );
ylabel( 'Similarity_model', 'Interpreter', 'none' );
title('96subject Model SC different  Homeostatic k=0')
set(gca,'FontName','Arial','FontSize',14)
grid on
%% load('Workingmemoryfen.mat')
% sub1=1
% sub=96 
% Workingmemory=Workingmemory(sub1:sub,1);
% Workingmemory=normalize(Workingmemory);
% UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
% UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
% % Workingmemory=normalize(Workingmemory);
% [r1,p1]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC1)
% [r2,p2]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC2)
% figure
% set(gcf,'color','w'); % 背景设为白色
% plot(Workingmemory, UPDATA_rsFCwmsFC1,'.k','markersize',18)
% text(-3,0.52,'r=0.0389 p=0.6249','FontSize',14);
% xlabel( 'Workingmemory', 'Interpreter', 'none' );
% ylabel( 'Similarity', 'Interpreter', 'none' );
% title('96subject Model SC same  Homeostatic k=6')
% grid on
% set(gca,'FontSize',14);
%
load('resttowmupdata96subparameter_GLM1.mat');
if restFC_DATA_sub==WM_FC_DATA_sub
    'no error'
end
i=0;
for sub=1:96
    i=i+1;
    rFC=restFC_DATA_matrix_96(:,:,sub);
    rest_vector1=uptrielement(rFC);
    wFC=wmFC_DATA_matrix_96(:,:,sub);
    wm_vector1=uptrielement(wFC);
    [resttowm_updata2,p2]=corrcoef(rest_vector1',wm_vector1');
    resttowm_updata1(i,1)=resttowm_updata2(1,2);
    p2(i,1)=p2(1,2);
end
i=0;
for sub=1:96
    i=i+1;
    rest_vector1= restDATA_FC_uptri{sub};
    wm_vector1=wmDATA_FC_uptri{sub};
    [resttowm_updata3,p3]=corrcoef(rest_vector1,wm_vector1);
    resttowm_updata4(i,1)=resttowm_updata3(1,2);
    p2(i,1)=p3(1,2);
end
load('WorkingmemoryACCURACY.mat','WorkingmemoryACCURACY','WorkingmemoryACCURACY_subject')
if  WorkingmemoryACCURACY_subject==restFC_DATA_sub;
    'no error'
end
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)

[r2,p2]=corrcoef(UPDATA_rsFCwmsFC2,resttowm_updata4)
figure
set(gcf,'color','w'); % 背景设为白色
plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)
text(0.57,0.75,'r=-0 p=0.99 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.4:0.1:0.8),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.4 0.75]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_model', 'Interpreter', 'none' );
ylabel( 'Similarity_data', 'Interpreter', 'none' );
title('96subject Working memory SC different  Homeostatic k=0')
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  K=6
clc;clear;close all;
load(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\6\subSCdifferentrsFCwmsFCupdata.mat']);
load('WorkingmemoryACCURACY.mat')
sub1=1
sub=96
WorkingmemoryACCURACY=WorkingmemoryACCURACY(sub1:sub,1);
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
[r1,p1]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1)
[r2,p2]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC2)
figure
set(gcf,'color','w'); % 背景设为白色
plot(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1,'.k',MarkerSize=18)
% text(-3,0.66,'r=0.1538 p=0.1348','FontSize',14);
text(-3,0.68,'r=-0.0199 p=0.8473','FontName','Arial','FontSize',18);
set(gca,'xtick',(-4:1:2),'ytick',(0.55:.05:0.7))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
xlim([-4 2]);ylim([0.55 0.7]);
% Label axes
xlabel( 'Accuracy', 'Interpreter', 'none' );
ylabel( 'Similarity_model', 'Interpreter', 'none' );
title('96subject Model SC different  Homeostatic k=6')
set(gca,'FontName','Arial','FontSize',14)
grid on
%% load('Workingmemoryfen.mat')
% sub1=1
% sub=96 
% Workingmemory=Workingmemory(sub1:sub,1);
% Workingmemory=normalize(Workingmemory);
% UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
% UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
% % Workingmemory=normalize(Workingmemory);
% [r1,p1]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC1)
% [r2,p2]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC2)
% figure
% set(gcf,'color','w'); % 背景设为白色
% plot(Workingmemory, UPDATA_rsFCwmsFC1,'.k','markersize',18)
% text(-3,0.52,'r=0.0389 p=0.6249','FontSize',14);
% xlabel( 'Workingmemory', 'Interpreter', 'none' );
% ylabel( 'Similarity', 'Interpreter', 'none' );
% title('96subject Model SC same  Homeostatic k=6')
% grid on
% set(gca,'FontSize',14);
%
load('resttowmupdata96subparameter_GLM1.mat');
if restFC_DATA_sub==WM_FC_DATA_sub
    'no error'
end
i=0;
for sub=1:96
    i=i+1;
    rFC=restFC_DATA_matrix_96(:,:,sub);
    rest_vector1=uptrielement(rFC);
    wFC=wmFC_DATA_matrix_96(:,:,sub);
    wm_vector1=uptrielement(wFC);
    [resttowm_updata2,p2]=corrcoef(rest_vector1',wm_vector1');
    resttowm_updata1(i,1)=resttowm_updata2(1,2);
    p2(i,1)=p2(1,2);
end
i=0;
for sub=1:96
    i=i+1;
    rest_vector1= restDATA_FC_uptri{sub};
    wm_vector1=wmDATA_FC_uptri{sub};
    [resttowm_updata3,p3]=corrcoef(rest_vector1,wm_vector1);
    resttowm_updata4(i,1)=resttowm_updata3(1,2);
    p2(i,1)=p3(1,2);
end
load('WorkingmemoryACCURACY.mat','WorkingmemoryACCURACY','WorkingmemoryACCURACY_subject')
if  WorkingmemoryACCURACY_subject==restFC_DATA_sub;
    'no error'
end
WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)

[r2,p2]=corrcoef(UPDATA_rsFCwmsFC2,resttowm_updata4)
figure
set(gcf,'color','w'); % 背景设为白色
plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)
text(0.57,0.75,'r=0.2808 p=0.0056 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.55:0.05:0.7),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.55 0.7]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_model', 'Interpreter', 'none' );
ylabel( 'Similarity_data', 'Interpreter', 'none' );
title('96subject Working memory')
grid on





















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% %%  K
% clc;clear;close all;
% load(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\K\subSCsamersFCwmsFCupdata.mat']);
% load('WorkingmemoryACCURACY.mat')
% sub1=1
% sub=96
% WorkingmemoryACCURACY=WorkingmemoryACCURACY(sub1:sub,1);
% WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
% UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
% UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
% WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
% [r1,p1]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1)
% [r2,p2]=corrcoef(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC2)
% figure
% set(gcf,'color','w'); % 背景设为白色
% plot(WorkingmemoryACCURACY, UPDATA_rsFCwmsFC1,'.k',MarkerSize=18)
% text(-3,0.62,'r=0.0617 p=0.5502','FontName','Arial','FontSize',18);
% set(gca,'xtick',(-4:1:2),'ytick',(0.5:.05:0.65))
% set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
% xlim([-4 2]);ylim([0.5 0.65]);
% % Label axes
% xlabel( 'Accuracy', 'Interpreter', 'none' );
% ylabel( 'Similarity_model', 'Interpreter', 'none' );
% title('96subject Model SC same  Homeostatic kmax')
% set(gca,'FontName','Arial','FontSize',14)
% grid on 
% % load('Workingmemoryfen.mat')
% % sub1=1
% % sub=96
% % Workingmemory=Workingmemory(sub1:sub,1);
% % Workingmemory=normalize(Workingmemory);
% % UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
% % UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
% % % Workingmemory=normalize(Workingmemory);
% % [r1,p1]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC1)
% % [r2,p2]=corrcoef(Workingmemory, UPDATA_rsFCwmsFC2)
% % figure
% % set(gcf,'color','w'); % 背景设为白色
% % plot(Workingmemory, UPDATA_rsFCwmsFC1,'.k','markersize',18)
% % text(-3,0.52,'r=0.0389 p=0.6249','FontSize',14);
% % xlabel( 'Workingmemory', 'Interpreter', 'none' );
% % ylabel( 'Similarity', 'Interpreter', 'none' );
% % title('96subject Model SC same  Homeostatic k=6')
% % grid on
% % set(gca,'FontSize',14);
% %
% load('resttowmupdata96subparameter_GLM1.mat');
% if restFC_DATA_sub==WM_FC_DATA_sub
%     'no error'
% end
% i=0;
% for sub=1:96
%     i=i+1;
%     rFC=restFC_DATA_matrix_96(:,:,sub);
%     rest_vector1=uptrielement(rFC);
%     wFC=wmFC_DATA_matrix_96(:,:,sub);
%     wm_vector1=uptrielement(wFC);
%     [resttowm_updata2,p2]=corrcoef(rest_vector1',wm_vector1');
%     resttowm_updata1(i,1)=resttowm_updata2(1,2);
%     p2(i,1)=p2(1,2);
% end
% i=0;
% for sub=1:96
%     i=i+1;
%     rest_vector1= restDATA_FC_uptri{sub};
%     wm_vector1=wmDATA_FC_uptri{sub};
%     [resttowm_updata3,p3]=corrcoef(rest_vector1,wm_vector1);
%     resttowm_updata4(i,1)=resttowm_updata3(1,2);
%     p2(i,1)=p3(1,2);
% end
% load('WorkingmemoryACCURACY.mat','WorkingmemoryACCURACY','WorkingmemoryACCURACY_subject')
% if  WorkingmemoryACCURACY_subject==restFC_DATA_sub;
%     'no error'
% end
% WorkingmemoryACCURACY=normalize(WorkingmemoryACCURACY);
% [r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)
% 
% [r2,p2]=corrcoef(UPDATA_rsFCwmsFC2,resttowm_updata4)
% figure
% set(gcf,'color','w'); % 背景设为白色
% plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)
% text(0.57,0.75,'r=0.2538 p=0.0126 ','FontName','Arial','FontSize',18);
% set(gca,'FontName','Arial','FontSize',14)
% set(gca,'xtick',(0.5:0.05:0.65),'ytick',(0.4:.1:0.8))
% set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
% xlim([0.5 0.65]);ylim([0.4 0.8]);
% % Label axes
% xlabel( 'Similarity_model', 'Interpreter', 'none' );
% ylabel( 'Similarity_data', 'Interpreter', 'none' );
% title('96subject Working memory')
% grid on