clc;clear;
close all;
load('100subparameter.mat', 'ms_100', 'ms_100subject')
ms_100_2=ms_100([1:44 46:100],:)
load('HCP_Congnitivedata\100PMAT.mat')
PMAT2=PMAT([1:44 46:100])
for brainindex=1:210
    MS=ms_100_2(:,brainindex);
    [r(brainindex),p(brainindex)]=corr(PMAT2,MS);
end
min(r)
max(r)
[index]=find(p<0.05);
brainr=r(index);
[brain1]=find(brainr > 0);
borignalnum_positivecorrelation=index(1,brain1)
r_positivecorrelation=r(1,borignalnum_positivecorrelation)
p_positivecorrelation=p(1,borignalnum_positivecorrelation)
figure;subplot(1,2,1);plot(r_positivecorrelation,'ob');ylabel('R')
subplot(1,2,2);plot(p_positivecorrelation,'ob');ylabel('P')
[brain2]=find(brainr < 0);
borignalnum_negativecorrelation=index(1,brain2)
r_negativecorrelation=r(1,borignalnum_negativecorrelation)
p_negativecorrelation=p(1,borignalnum_negativecorrelation)
% figure;subplot(1,2,1);plot(r_negativecorrelation,'ob');ylabel('R')
% subplot(1,2,2);plot(p_negativecorrelation,'ob');ylabel('P')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MS_positive=mean(ms_100_2(:,borignalnum_positivecorrelation),2)
MS_negative=mean(ms_100_2(:,borignalnum_negativecorrelation),2)
MS_diff=MS_positive-MS_negative;
[rr1,pp1]=corr(MS_positive,PMAT2)

[rr2,pp2]=corr(MS_negative,PMAT2)

[rr3,pp3]=corr(MS_diff,PMAT2)
%%

[x,order]=sort(MS_positive)
y=PMAT2(order)
figure
set(gcf,'color','w');

% subplot(4,3,1:9)
% fig9=imread('fig9R_MSandPMAT.png');
% imagesc(fig9)
% box on
% colormap('jet');
% caxis([-0.30 0.33])
% ch = colorbar('horiz');
% set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);
% 

subplot(4,3,10)
P= polyfit(x, y, 1);
x2=0.05:0.01:0.2;
yi= polyval(P, x2);  %求对应y值
plot(x,y,'.k','markersize',18);
hold on
plot(x2,yi,'r-','linewidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
text(0.1,7,['r=0.3024' sprintf('\n') 'p=0.0023 '],'FontName','Arial','FontSize',18);
set(gca,'xtick',(0.05:.05:0.22),'ytick',(5:5:25))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.0f'))
xlim([0.05 0.2]);
ylim([5 25])
xlabel( '$$\left\langle\bar r_i\right\rangle_{PCR}$$','FontName','Arial','FontSize',24);
ylabel( 'PMAT','FontName','Arial','FontSize',18);
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[rr2,pp2]=corr(MS_negative,PMAT2)
[x,order]=sort(MS_negative)
y=PMAT2(order)
subplot(4,3,11)
P= polyfit(x, y, 1);
x2=0.08:0.01:0.13;
yi= polyval(P, x2);
plot(x,y,'.k','markersize',18);
hold on
plot(x2,yi,'r-','linewidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
text(0.1,7,['r=-0.3823' sprintf('\n') 'p=0 '],'FontName','Arial','FontSize',18);
set(gca,'xtick',(0.09:.01:0.122),'ytick',(5:5:25))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.0f'))
xlim([0.09 0.122]);
ylim([5 25])
xlabel( '$$\left\langle\bar r_i\right\rangle_{NCR}$$','FontName','Arial','FontSize',24);
ylabel( 'PMAT','FontName','Arial','FontSize',18);
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[rr3,pp3]=corr(MS_diff,PMAT2)
[x,order]=sort(MS_diff)
y=PMAT2(order)
subplot(4,3,12)
P= polyfit(x, y, 1);
x2=-0.05:0.01:0.12;
yi= polyval(P, x2);
plot(x,y,'.k','markersize',18);
hold on
plot(x2,yi,'r-','linewidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
text(-0.02,7,['r=0.4350' sprintf('\n') 'p=0 '],'FontName','Arial','FontSize',18);
set(gca,'xtick',(-0.04:.04:0.08),'ytick',(5:5:25))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.0f'))
xlim([-0.04 0.08]);
ylim([5 25])
xlabel( '$$\left\langle\bar r_i\right\rangle_{PCR}$$ - $$\left\langle\bar r_i\right\rangle_{NCR}$$','FontName','Arial','FontSize',24);
ylabel( 'PMAT','FontName','Arial','FontSize',18);
grid on