clc;clear;
close all;
load('100subparameter.mat', 'ms_100', 'ms_100subject')
ms_100_2=ms_100;

load('HCP_Congnitivedata\100ListSortingWorkingmemory.mat')
ListSortingWorkingmemory2=ListSortingWorkingmemory;

for brainindex=1:210
    MS=ms_100_2(:,brainindex);
    [r(brainindex),p(brainindex)]=corr(ListSortingWorkingmemory2,MS);
end
% Z=[r;P]


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
   figure;subplot(1,2,1);plot(r_negativecorrelation,'ob');ylabel('R')
  subplot(1,2,2);plot(p_negativecorrelation,'ob');ylabel('P')


figure
plot(r)
xlabel('Brain')
ylabel('r')
hold on
plot(borignalnum_positivecorrelation,ones(1,7).*0.35,'*r')

hold on
plot(borignalnum_negativecorrelation,ones(1,15).*0.3,'*b')
ylim([-0.4 0.4])

hold on
plot([68,68],[-0.4,0.4],'--r')
hold on
plot([124,124],[-0.4,0.4],'--r')
hold on
plot([162,162],[-0.4,0.4],'--r')
hold on
plot([174,174],[-0.4,0.4],'--r')
hold on
plot([188,188],[-0.4,0.4],'--r')
hold on
plot([210,210],[-0.4,0.4],'--r')


xlim([0,210])
 xticks([68,124,162,174,188,210,246])
text(0,-0.35,'Frontal Lobe')
text(68,-0.35,'Temporal Lobe')
text(124,-0.35,'Parietal Lobe')
text(162,-0.35,'Insular Lobe')
text(174,-0.35,'Limbic Lobe')
text(188,-0.35,'Occipital Lobe')



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MS_positive=mean(ms_100_2(:,borignalnum_positivecorrelation),2)
MS_negative=mean(ms_100_2(:,borignalnum_negativecorrelation),2)
MS_diff=MS_positive-MS_negative;
[rr1,pp1]=corr(MS_positive,ListSortingWorkingmemory2)
[rr2,pp2]=corr(MS_negative,ListSortingWorkingmemory2)
[rr3,pp3]=corr(MS_diff,ListSortingWorkingmemory2)
%%
[x,order]=sort(MS_positive)
y=ListSortingWorkingmemory2(order)
figure
set(gcf,'color','w'); 
% subplot(4,3,1:9)
% fig9=imread('fig9R_MSandWM.png');   
% imagesc(fig9)
% box on
% colormap('jet');
% caxis([-0.37 0.27])
% ch = colorbar('horiz');
% set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);
subplot(4,3,10)
P= polyfit(x, y, 1);   
x2=0.05:0.01:0.2;
yi= polyval(P, x2);  
plot(x,y,'.k','markersize',18);
hold on
plot(x2,yi,'r-','linewidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
text(0.1,140,['r=0.3225' sprintf('\n') 'p=0.0011 '],'FontName','Arial','FontSize',18);
set(gca,'xtick',(0.05:.05:0.22),'ytick',(90:20:150))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.0f'))
xlim([0.05 0.2]);
ylim([90 150])
xlabel( '$$\left\langle\bar r_i\right\rangle_{PCR}$$','FontName','Arial','FontSize',24);
ylabel( 'Working memory','FontName','Arial','FontSize',18);
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[rr2,pp2]=corr(MS_negative,ListSortingWorkingmemory2)
[x,order]=sort(MS_negative)
y=ListSortingWorkingmemory2(order)
subplot(4,3,11)
P= polyfit(x, y, 1);  
x2=0.08:0.01:0.12;
yi= polyval(P, x2); 
plot(x,y,'.k','markersize',18);
hold on
plot(x2,yi,'r-','linewidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
text(0.1,140,['r=-0.4087' sprintf('\n') 'p=0 '],'FontName','Arial','FontSize',18);
set(gca,'xtick',(0.08:.01:0.12),'ytick',(90:20:150))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.0f'))
xlim([0.08 0.12]);
ylim([90 150])
xlabel( '$$\left\langle\bar r_i\right\rangle_{NCR}$$','FontName','Arial','FontSize',24);
ylabel( 'Working memory','FontName','Arial','FontSize',18);
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
[rr3,pp3]=corr(MS_diff,ListSortingWorkingmemory2)
[x,order]=sort(MS_diff)
y=ListSortingWorkingmemory2(order)
subplot(4,3,12)
P= polyfit(x, y, 1);   
x2=-0.05:0.01:0.12;
yi= polyval(P, x2); 
plot(x,y,'.k','markersize',18);
hold on
plot(x2,yi,'r-','linewidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
text(0.1,140,['r=0.4695' sprintf('\n') 'p=0 '],'FontName','Arial','FontSize',18);
set(gca,'xtick',(-0.05:.05:0.12),'ytick',(90:20:150))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.0f'))
xlim([-0.05 0.12]);
ylim([90 150])
xlabel( '$$\left\langle\bar r_i\right\rangle_{PCR}$$ - $$\left\langle\bar r_i\right\rangle_{NCR}$$','FontName','Arial','FontSize',24);
ylabel( 'Working memory','FontName','Arial','FontSize',18);
grid on