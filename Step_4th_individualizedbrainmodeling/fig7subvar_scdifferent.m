%% 个体差异 前100被试 SC 不同
clc;clear;close all;
%model k=0
K=0
load(['SubjectDifferent_model\',num2str(K),'\modelSubsFC.mat'],'R');
r2=R; 
%data 
load('DataSubjectDifferences.mat','R','P');
R2=R;
[rr2,pp2]=corrcoef(r2',R2')
[rr2,pp2]=corr(r2',R2')
%-------------------------------------------------
[x,order]=sort(r2');
y=(R2(order))';
figure
set(gcf,'color','w'); % 背景设为白色
subplot(2,3,1)
P= polyfit(x, y, 1)
x2=0:0.01:0.20
yi= polyval(P, x2);  %求对应y值
plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
set(gca,'xtick',(0:.05:0.20),'ytick',(0.60:.05:0.85))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
text(0.01,0.82,['r=0.1444' sprintf('\n') ' p=0.1517'],'FontName','Arial','FontSize',18);
% text(0.15,0.65,[' r=0.14 ' sprintf('\n') ' p=0.15'],'FontName','Arial','FontSize',18);
xlim([0 0.2]);
ylim([0.6 0.88])
xlabel( '{Var_{model}}','FontName','Arial','FontSize',18);
ylabel( '{Var_{data}}','FontName','Arial','FontSize',18);
grid on
title('K=0','FontName','Arial','FontSize',18);
% set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.3f'))
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
%data 
load('DataSubjectDifferences.mat','R','P');
R2=R;  
%model k=3
K=3
load(['SubjectDifferent_model\',num2str(K),'\modelSubsFC.mat'],'R');
r2=R   
[rr2,pp2]=corrcoef(r2',R2')
%-------------------------------------------------
[x,order]=sort(r2');
y=(R2(order))';
set(gcf,'color','w'); % 背景设为白色
subplot(2,3,2)
P= polyfit(x, y, 1)
x2=0:0.01:0.20
yi= polyval(P, x2);  %求对应y值

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);

set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)

set(gca,'xtick',(0:.05:0.20),'ytick',(0.60:.05:0.85))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
text(0.01,0.82,['r=0.2029' sprintf('\n') ' p=0.0429'],'FontName','Arial','FontSize',18);
% text(0.15,0.65,[' r=0.20 ' sprintf('\n') ' p=0.04'],'FontName','Arial','FontSize',18);
xlim([0 0.2]);
ylim([0.6 0.88])
xlabel( '{Var_{model}}','FontName','Arial','FontSize',18);
ylabel( '{Var_{data}}','FontName','Arial','FontSize',18);
grid on
title('K=3','FontName','Arial','FontSize',18);
% 
% set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.3f'))
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
%data  
load('DataSubjectDifferences.mat','R','P');
R2=R;   
%moel  k=6
K=6
load(['SubjectDifferent_model\',num2str(K),'\modelSubsFC.mat'],'R');
r2=R;
[rr2,pp2]=corrcoef(r2',R2')
%-------------------------------------------------
[x,order]=sort(r2');
y=(R2(order))';
subplot(2,3,3)

P= polyfit(x, y, 1)   %2阶多项式拟合
x2=0:0.01:0.2
yi= polyval(P, x2);  %求对应y值

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

set(gca,'xtick',(0:.05:0.20),'ytick',(0.60:.05:0.85))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

 text(0.05,0.61,'Person"s r=0.2543 p=0.0107','FontSize',14); 

%text(0.15,0.65,[' r=0.25 ' sprintf('\n') ' p=0.01'],'FontName','Arial','FontSize',18);
ylim([0.6 0.88])
xlabel( '{Var_{model}}','FontName','Arial','FontSize',18);
ylabel( '{Var_{data}}','FontName','Arial','FontSize',18);
grid on
title('K=6','FontName','Arial','FontSize',18);
sgtitle('Without homeostatic principle','FontName','Arial','FontSize',24)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
%data  
load('DataSubjectDifferences.mat','R','P');
R2=R; 
%model  Homeostatic K=0
K=0;
load(['SubjectDifferent_model\Steady\',num2str(K),'\modelSubsFC.mat'],'R');
r4=R;    

[rr4,pp4]=corrcoef(r4',R2')
%-------------------------------------------------
[x,order]=sort(r4');
y=(R2(order))';

subplot(2,3,4)

P= polyfit(x, y, 1)  
x2=0.1:0.01:0.2
yi= polyval(P, x2);  

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);

set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

set(gca,'xtick',(0:.02:0.20),'ytick',(0.60:.05:0.85))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

  text(0.12,0.61,'Person"s r=-0.1851 p=0.0652 ','FontSize',14);
%text(0.16,0.65,['r=-0.19 ' sprintf('\n') ' p=0.07'],'FontName','Arial','FontSize',18);
ylim([0.6 0.88])
xlabel( '{Var_{model}}','FontName','Arial','FontSize',18);
ylabel( '{Var_{data}}','FontName','Arial','FontSize',18);
grid on
title('K=0','FontName','Arial','FontSize',18);

%% ------------------------------------------------------------------------
clc;clear;
%data  
load('DataSubjectDifferences.mat','R','P');
R2=R; 
%model  Homeostatic K=3
K=3;
load(['SubjectDifferent_model\Steady\',num2str(K),'\modelSubsFC.mat'],'R');
r4=R;    

[rr4,pp4]=corrcoef(r4',R2')
%-------------------------------------------------
[x,order]=sort(r4');
y=(R2(order))';

subplot(2,3,5)

P= polyfit(x, y, 1)  
x2=0.1:0.01:0.25
yi= polyval(P, x2);  

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);

set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

set(gca,'xtick',(0:.02:0.22),'ytick',(0.60:.05:0.85))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
text(0.16,0.65,['r=0.2081 ' sprintf('\n') ' p=0.0378'],'FontName','Arial','FontSize',18);
% text(0.16,0.65,['r=0.21 ' sprintf('\n') ' p=0.04'],'FontName','Arial','FontSize',18);
ylim([0.6 0.88])
xlim([0.12 0.22])
xlabel( '{Var_{model}}','FontName','Arial','FontSize',18);
ylabel( '{Var_{data}}','FontName','Arial','FontSize',18);
grid on
title('K=3','FontName','Arial','FontSize',18);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
%data 
load('DataSubjectDifferences.mat','R','P');
R2=R;                    
%model  Homeostatic K6
K=6
load(['SubjectDifferent_model\Steady\',num2str(K),'\modelSubsFC.mat'],'R');
r4=R                      


[rr4,pp4]=corrcoef(r4',R2')
%-------------------------------------------------
[x,order]=sort(r4')
y=(R2(order))'
subplot(2,3,6)
P= polyfit(x, y, 1)  
x2=0.1:0.01:0.27
yi= polyval(P, x2); 

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);

set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
set(gca,'xtick',(0.10:.05:0.25),'ytick',(0.60:.05:0.85))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

  text(0.12,0.61,'Person"s r=0.3192 p=0.0012 ','FontSize',14); 
%text(0.2,0.65,['r=0.32 ' sprintf('\n') ' p=0'],'FontName','Arial','FontSize',18);

xlabel( '{Var_{model}}','FontName','Arial','FontSize',18);
ylabel( '{Var_{data}}','FontName','Arial','FontSize',18);
xlim([0.1 0.26])
ylim([0.6 0.88])
grid on
title('K=6','FontName','Arial','FontSize',18);
% sgtitle('With homeostatic principle','FontName','Arial','FontSize',24)
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%

%%








%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
close all;
%data 
load('DataSubjectDifferences.mat','R','P');
R2=R;                    
%model  Homeostatic K6
kk=0
for K=0:6
kk=kk+1
    load(['SubjectDifferent_model\',num2str(K),'\modelSubsFC.mat'],'R','r_sub');

   for cx=1:50 
     r3=r_sub(cx,:)                     
[rr3(kk,cx),pp3(kk,cx)]=corr(r3',R2')
   end

    r4=R  
if r4==mean(r_sub)
[rr4(kk,1),pp4(kk,1)]=corr(r4',R2')
else
    error
end

end
%
r_mean=mean(rr3,2);
p_mean=mean(pp3,2);

r_mean(end)
p_mean(end)
%
for kk=1:7
r_std(kk,1)=std(rr3(kk,:))
end 
%
figure
subplot(1,2,1)
% plot(0:6,rr4,'-OB')

x=0:6;y=r_mean;err=r_std;
errorbar(x,y,err,'-o','linewidth',1.5)
% shadedErrorBar(x,y,err)  % boxplot(rr3)
hold on
plot([3:6],0.28.*ones(1,4),'*r')

xlim([-0.5 6.5])
ylim([0 0.3])
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
set(gca,'xtick',(0:1:6),'ytick',(0:.05:0.3))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
xlabel('Extent of heterogeneity K','FontName','Arial','FontSize',18);
ylabel('{Corr_{var}}','FontName','Arial','FontSize',18);


clc;clear;
%data  
load('DataSubjectDifferences.mat','R','P');
R2=R;   
%moel  k=6
K=6
load(['SubjectDifferent_model\',num2str(K),'\modelSubsFC.mat'],'R');
r2=R;
[rr2,pp2]=corrcoef(r2',R2')
%-------------------------------------------------
[x,order]=sort(r2');
y=(R2(order))';
subplot(1,2,2)

P= polyfit(x, y, 1)   %2阶多项式拟合
x2=0:0.01:0.2
yi= polyval(P, x2);  %求对应y值

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

set(gca,'xtick',(0:.05:0.20),'ytick',(0.60:.05:0.85))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

 text(0.05,0.61,'{Corr_{var}}=0.2543 p=0.0107','FontSize',14); 

%text(0.15,0.65,[' r=0.25 ' sprintf('\n') ' p=0.01'],'FontName','Arial','FontSize',18);
ylim([0.6 0.88])
xlabel( '{Var_{model}}','FontName','Arial','FontSize',18);
ylabel( '{Var_{data}}','FontName','Arial','FontSize',18);
grid on
title('K=6','FontName','Arial','FontSize',18);
% sgtitle('Without homeostatic principle','FontName','Arial','FontSize',24)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clc;clear;
close all;
%data 
load('DataSubjectDifferences.mat','R','P');
R2=R;                    
%model  Homeostatic K6
kk=0
for K=0:6
kk=kk+1
    load(['SubjectDifferent_model\Steady\',num2str(K),'\modelSubsFC.mat'],'R','r_sub');
for cx=1:50 
     r3=r_sub(cx,:)                     
[rr3(kk,cx),pp3(kk,cx)]=corr(r3',R2')
   end

    r4=R  
if r4==mean(r_sub)
[rr4(kk,1),pp4(kk,1)]=corr(r4',R2')
else
    error
end

end

r_mean=mean(rr3,2)
p_mean=mean(pp3,2)

r_mean(end)
p_mean(end)
%
for kk=1:7
r_std(kk,1)=std(rr3(kk,:))
end 
%
figure
subplot(1,2,1)
% plot(0:6,rr4,'-OB')
x=0:6;y=r_mean;err=r_std;
errorbar(x,y,err,'-o','linewidth',1.5)

hold on
plot([3:6],0.38.*ones(1,4),'*r')

xlim([-0.5 6.5])
ylim([-0.3 0.43])
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
set(gca,'xtick',(0:1:6),'ytick',(-0.3:.1:0.4))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))
xlabel('Extent of heterogeneity K','FontName','Arial','FontSize',18);
ylabel('{Corr_{var}}','FontName','Arial','FontSize',18);


%
clc;clear;
%data 
load('DataSubjectDifferences.mat','R','P');
R2=R;                    
%model  Homeostatic K6
K=6
load(['SubjectDifferent_model\Steady\',num2str(K),'\modelSubsFC.mat'],'R');
r4=R                      


[rr4,pp4]=corrcoef(r4',R2')
%-------------------------------------------------
[x,order]=sort(r4')
y=(R2(order))'

subplot(1,2,2)
P= polyfit(x, y, 1)  
x2=0.1:0.01:0.27
yi= polyval(P, x2); 

plot(x,y,'.k','Markersize',24);
hold on
plot(x2,yi,'r-','LineWidth',5);

set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)
set(gca,'xtick',(0.10:.05:0.25),'ytick',(0.60:.05:0.85))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

  text(0.12,0.61,'$Corr_{var}$=0.2996 p=0.0045 ','FontSize',14); 
%text(0.2,0.65,['r=0.32 ' sprintf('\n') ' p=0'],'FontName','Arial','FontSize',18);

xlabel( '{Var_{model}}','FontName','Arial','FontSize',18);
ylabel( '{Var_{data}}','FontName','Arial','FontSize',18);
xlim([0.1 0.26])
ylim([0.6 0.88])
grid on
title('K=6','FontName','Arial','FontSize',18);
% sgtitle('With homeostatic principle','FontName','Arial','FontSize',24)





