%%  模拟的updata 和数据上的 update
%%scdifferent
clc;clear;
close all;
load(['modelrsFCtowmsFC_updata\SC_different\0\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1
sub=96
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
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
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)
%
[x,order]=sort(UPDATA_rsFCwmsFC1);
y=(resttowm_updata1(order))';
P= polyfit(x, y, 1)
x2=0.1:0.1:0.6
yi= polyval(P, x2);  %求对应y值

figure
subplot(2,3,1)
set(gcf,'color','w'); % 背景设为白色

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14)

text(0.3,0.75,'r=-0.3077 p=0.0023 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.2:0.1:0.5),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.15 0.52]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_{model}', 'FontName','Arial','FontSize',18);
ylabel( 'Similarity_{data}', 'FontName','Arial','FontSize',18);
title('K=0','FontName','Arial','FontSize',18);
grid on
%%
clc;clear;
load(['modelrsFCtowmsFC_updata\SC_different\3\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1
sub=96
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
UPDATA_rsFCwmsFC2=UPDATA_rsFCwmsFC_model2(sub1:sub,1)
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
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)
%
[x,order]=sort(UPDATA_rsFCwmsFC1);
y=(resttowm_updata1(order))';
P= polyfit(x, y, 1)
x2=0.1:0.1:0.6
yi= polyval(P, x2);  %求对应y值

subplot(2,3,2)
set(gcf,'color','w'); % 背景设为白色

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14)

text(0.3,0.75,'r=-0.2570 p=0.0115 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.2:0.1:0.5),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.15 0.52]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_{model}', 'FontName','Arial','FontSize',18);
ylabel( 'Similarity_{data}', 'FontName','Arial','FontSize',18);
title('K=3','FontName','Arial','FontSize',18);
grid on

%%
clc;clear;
load(['modelrsFCtowmsFC_updata\SC_different\6\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1
sub=96
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
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
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)
%%
[x,order]=sort(UPDATA_rsFCwmsFC1);
y=(resttowm_updata1(order))';
P= polyfit(x, y, 1)
x2=0.1:0.1:0.6
yi= polyval(P, x2);  %求对应y值

subplot(2,3,3)
plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14)
% plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)

text(0.2,0.5,'r=-0.2614 p=0.0101 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.2:0.1:0.5),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.15 0.5]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_{model}', 'FontName','Arial','FontSize',18);
ylabel( 'Similarity_{data}', 'FontName','Arial','FontSize',18);
title('K=6','FontName','Arial','FontSize',18);
grid on


%%
clc;clear;
load(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\0\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1
sub=96
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
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
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)
%%
[x,order]=sort(UPDATA_rsFCwmsFC1);
y=(resttowm_updata1(order))';
P= polyfit(x, y, 1)
x2=0.1:0.1:0.8
yi= polyval(P, x2);  %求对应y值

subplot(2,3,4)
plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14)

% plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)
text(0.57,0.75,'r=-1.7148e-05 p=0.9999 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.4:0.1:0.8),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.4 0.75]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_{model}', 'FontName','Arial','FontSize',18);
ylabel( 'Similarity_{data}', 'FontName','Arial','FontSize',18);
title('K=0','FontName','Arial','FontSize',18);
grid on

%%
clc;clear;
load(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\3\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1
sub=96
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
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
[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)
%%
[x,order]=sort(UPDATA_rsFCwmsFC1);
y=(resttowm_updata1(order))';
P= polyfit(x, y, 1)
x2=0.1:0.1:0.8
yi= polyval(P, x2);  %求对应y值

subplot(2,3,5)
plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14)

% plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)
text(0.57,0.75,'r=0.1525 p=0.1381 ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.4:0.1:0.8),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.4 0.75]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_{model}', 'FontName','Arial','FontSize',18);
ylabel( 'Similarity_{data}', 'FontName','Arial','FontSize',18);
title('K=3','FontName','Arial','FontSize',18);
grid on
%%
clc;clear;
load(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\6\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1
sub=96
UPDATA_rsFCwmsFC1=UPDATA_rsFCwmsFC_model1(sub1:sub,1);
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

[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)
%
[x,order]=sort(UPDATA_rsFCwmsFC1);
y=(resttowm_updata1(order))';
P= polyfit(x, y, 1)
x2=0.1:0.1:0.8
yi= polyval(P, x2);  %求对应y值

subplot(2,3,6)
plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14)
text(0.57,0.75,'r=0.2808 p=0.0056 ','FontName','Arial','FontSize',18);
set(gca,'xtick',(0.55:0.05:0.7),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.55 0.7]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_{model}', 'FontName','Arial','FontSize',18);
ylabel( 'Similarity_{data}', 'FontName','Arial','FontSize',18);
title('K=6','FontName','Arial','FontSize',18);
grid on








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%














%%

%%
clc;clear;
close all

kk=0
for K=0:6
    kk=kk+1

load(['modelrsFCtowmsFC_updata\SC_different\',num2str(K),'\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1;sub=96

UPDATE_rsFCwmsFC1=UPDATE_rsFCwmsFC_model1(sub1:sub,1);


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

for cx=1:50
UPDATE_rsFCwmsFC2=UPDATE_rsFCwmsFC(cx,1:96)';
[r0(kk,cx),p0(kk,cx)]=corr(UPDATE_rsFCwmsFC2,resttowm_updata1)
end



[r1(kk,1),p1(kk,1)]=corr(UPDATE_rsFCwmsFC1,resttowm_updata1)
end
%
r_mean=mean(r0,2)
p_mean=mean(p0,2)

r_mean(5)
p_mean(5)
%
for kk=1:7
r_std(kk,1)=std(r0(kk,:))
end 



figure
subplot(1,2,1)
% plot(0:6,r1,'-OB')
x=0:6;y=r_mean;err=r_std;
errorbar(x,y,err,'-o','linewidth',1.5)

hold on
plot([0:6],-0.20.*ones(1,7),'*r')

xlim([-0.5 6.5])
ylim([-0.32 -0.19])
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
set(gca,'xtick',(0:1:6),'ytick',(-0.32:.02:-0.1))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
xlabel('Extent of heterogeneity K','FontName','Arial','FontSize',18);
ylabel('$Corr_{update}$','FontName','Arial','FontSize',18);

%
clc;clear;
load(['modelrsFCtowmsFC_updata\SC_different\4\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1
sub=96
UPDATE_rsFCwmsFC1=UPDATE_rsFCwmsFC_model1(sub1:sub,1);
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
[r1,p1]=corrcoef(UPDATE_rsFCwmsFC1,resttowm_updata1)

[x,order]=sort(UPDATE_rsFCwmsFC1);
y=(resttowm_updata1(order))';
P= polyfit(x, y, 1)
x2=0.1:0.1:0.6
yi= polyval(P, x2);  %求对应y值

subplot(1,2,2)
plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14)
% plot(UPDATA_rsFCwmsFC1,resttowm_updata1,'.k','markersize',18)

text(0.2,0.5,'$$\rm{Corr_{update}=-0.2207}$$  $$ \;\rm{p=0.0313}$$ ','FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14)
set(gca,'xtick',(0.2:0.1:0.5),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.15 0.5]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_{model}', 'FontName','Arial','FontSize',18);
ylabel( 'Similarity_{data}', 'FontName','Arial','FontSize',18);
title('K=4','FontName','Arial','FontSize',18);
grid on




%%
clc;clear;
close all

kk=0
for K=0:6
    kk=kk+1

load(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\',num2str(K),'\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1;sub=96;
UPDATA_rsFCwmsFC1=UPDATE_rsFCwmsFC_model1(sub1:sub,1);

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

for cx=1:50
UPDATA_rsFCwmsFC2=UPDATE_rsFCwmsFC(cx,1:96)';
[r0(kk,cx),p0(kk,cx)]=corr(UPDATA_rsFCwmsFC2,resttowm_updata1)
end


[r1(kk,1),p1(kk,1)]=corr(UPDATA_rsFCwmsFC1,resttowm_updata1)
end
%
r_mean=mean(r0,2)
p_mean=mean(p0,2)

r_mean(5)
p_mean(5)
%
for kk=1:7
r_std(kk,1)=std(r0(kk,:))
end 



figure
subplot(1,2,1)
% plot(0:6,r1,'-OB')
x=0:6;y=r_mean;err=r_std;
errorbar(x,y,err,'-o','linewidth',1.5)


hold on
plot([4:6],0.33.*ones(1,3),'*r')

xlim([-0.2 6.5])
ylim([-0.02 0.35])
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
set(gca,'xtick',(0:1:6),'ytick',(0:.05:0.35))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
xlabel('Extent of heterogeneity K','FontName','Arial','FontSize',18);
ylabel('$Corr_{update}$','FontName','Arial','FontSize',18);


%
clc;clear;
load(['modelrsFCtowmsFC_updata\SC_different\Homeostatic\4\subSCdifferentrsFCwmsFCupdata.mat']);
sub1=1
sub=96
UPDATA_rsFCwmsFC1=UPDATE_rsFCwmsFC_model1(sub1:sub,1);
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

[r1,p1]=corrcoef(UPDATA_rsFCwmsFC1,resttowm_updata1)
%
[x,order]=sort(UPDATA_rsFCwmsFC1);
y=(resttowm_updata1(order))';
P= polyfit(x, y, 1)
x2=0.1:0.1:0.8
yi= polyval(P, x2);  %求对应y值

subplot(1,2,2)
plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14)
text(0.57,0.75,'$Corr_{update}$=0.2887 p=0.0048 ','FontName','Arial','FontSize',18);
set(gca,'xtick',(0.55:0.05:0.7),'ytick',(0.4:.1:0.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlim([0.55 0.7]);ylim([0.4 0.8]);
% Label axes
xlabel( 'Similarity_{model}', 'FontName','Arial','FontSize',18);
ylabel( 'Similarity_{data}', 'FontName','Arial','FontSize',18);
title('K=4','FontName','Arial','FontSize',18);
grid on
