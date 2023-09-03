%% 2 data MS   DATA FC DEGREE polyfit2
close all;
clc;clear;
%1 MS
load('100subparameter_samesc.mat')
ms=mean(ms_100);
mean(ms)

DTI_gunter=DTI_gunter_100_mean2;
mean(mean(DTI_gunter))

FC_DATA_matrix=mean(FC_DATA_matrix_100,3)
%DATA
%1 data MS   DATA FC DEGREE  line corr
FC_DATA_degree=sum(FC_DATA_matrix);
[r_data,p_data]=corrcoef(FC_DATA_degree',ms')

[x,order]=sort(FC_DATA_degree)
y=ms(order)


figure
set(gcf,'color','w'); 

subplot(2,5,1)
P= polyfit(x, y, 2)  
yi= polyval(P, [10:80]); 

%U型”关系的稳健性检验  一元二次方程回归 检验
ff=@(beta,x)beta(1).*x.*x+beta(2)*x+beta(3);%根据散点图趋势建立方程
beta0=[P(1),P(2),P(3)];%beta0为b1,b2的初始值。
opt=statset;%创建结构体变量类
opt.Robust='on';%开启回归稳健性方法
nlm1=NonLinearModel.fit(x,y,ff,beta0,'Options',opt)

plot(x,y,'.k','markersize',18);
hold on
plot([10:80],yi,'r-','linewidth',5);

set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)

% text(15,0.19,"F=84.3  p=1.6e-28 Adjusted R^2=0.405");
text(15,0.19,['R^2=0.405' sprintf('\n') 'p=0'],'FontName','Arial','FontSize',18);

% set(gca,'xtick',(10:10:80),'ytick',(0:.05:0.22))
set(gca,'xtick',(10:10:80),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([10 80]);
% ylim([0 0.22])
ylim([0.02 0.22])
% ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'eFC degree','FontName','Arial','FontSize',18);
grid on
 title('Data','FontName','Arial','FontSize',24)


%%
clc;clear;
%MODEL
K=0
load(['FCdegreeAndMS\model\',num2str(K),'\FCdegree_MS.mat'])
FC_model_degree=model_FC_degree2;

% Fit
[x,order]=sort(FC_model_degree)
y=ms(order)
P= polyfit(x, y, 2)   
yi= polyval(P, x); 

subplot(2,5,2)
plot(x,y,'.k','markersize',18);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

% set(gca,'xtick',(8:2:18),'ytick',(0:.1:0.22))
set(gca,'xtick',(8:2:18),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([8 18]);
% ylim([0 0.22])
ylim([0.02 0.22])
ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'sFC degree','FontName','Arial','FontSize',18);
title('K=0','FontName','Arial','FontSize',18);
grid on;

%%
clc;clear

K=5
load(['FCdegreeAndMS\model\',num2str(K),'\FCdegree_MS.mat'])
FC_model_degree=model_FC_degree2;
[x,order]=sort(FC_model_degree)

y=ms(order)
P= polyfit(x, y, 2)   
yi= polyval(P, x);  

subplot(2,5,3)
plot(x,y,'.k','markersize',18);
% hold on
% plot(x,yi,'r-');
% text(9,0.2,"F=4.75  p=0.00948 Adjusted R^2=0.0297")
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

% set(gca,'xtick',(8:2:18),'ytick',(0:.1:0.22))
set(gca,'xtick',(8:2:18),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([8 18]);
% ylim([0 0.22])
ylim([0.02 0.22])
ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'sFC degree','FontName','Arial','FontSize',18);
title('K=5','FontName','Arial','FontSize',18);
grid on;

clc;clear;

K=10
load(['FCdegreeAndMS\model\',num2str(K),'\FCdegree_MS.mat'])
FC_model_degree=model_FC_degree2;

[x,order]=sort(FC_model_degree)
y=ms(order)
P= polyfit(x, y, 2)   
yi= polyval(P, x);  
subplot(2,5,4)
plot(x,y,'.k','markersize',18);
% hold on
% plot(x,yi,'r-');
% text(9,0.2,"F=4.78 p=0.00919 Adjusted R^2=0.0299");
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

% set(gca,'xtick',(8:2:18),'ytick',(0:.1:0.22))
set(gca,'xtick',(8:2:18),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([8 18]);
% ylim([0 0.22])
ylim([0.02 0.22])
ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'sFC degree','FontName','Arial','FontSize',18);
title('K=10','FontName','Arial','FontSize',18);
grid on;

clc;clear;
K=14
load(['FCdegreeAndMS\model\',num2str(K),'\FCdegree_MS.mat'])
FC_model_degree=model_FC_degree2;

[x,order]=sort(FC_model_degree)
y=ms(order)
P= polyfit(x, y, 2)  
yi= polyval(P, x);  

subplot(2,5,5)
plot(x,y,'.k','markersize',18);
% hold on
% plot(x,yi,'r-');
% text(9,0.2,"F=4.31 p=0.0144 Adjusted R^2=0.0263");
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

% set(gca,'xtick',(8:2:18),'ytick',(0:.1:0.22))
set(gca,'xtick',(8:2:18),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([8 18]);
% ylim([0 0.22])
ylim([0.02 0.22])
ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'sFC degree','FontName','Arial','FontSize',18);
title('K=14','FontName','Arial','FontSize',18);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
K=0
load(['FCdegreeAndMS\model\steady\',num2str(K),'\FCdegree_MS.mat'])
FC_model_degree=model_FC_degree2;
%%Fit: 

[x,order]=sort(FC_model_degree)
y=ms(order)
P= polyfit(x, y, 2)  
yi= polyval(P, x); 

subplot(2,5,7)
plot(x,y,'.k','markersize',18);
% hold on
% plot(x,yi,'r-');
% text(13,0.2,"F=45.6  p=1.57e-17 Adjusted R^2=0.267");
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

% set(gca,'xtick',(12:2:18),'ytick',(0:.1:0.22))
set(gca,'xtick',(12:2:18),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([12 18]);ylim([0.02 0.22])
ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'sFC degree','FontName','Arial','FontSize',18);
title('Homeostatic K=0','FontName','Arial','FontSize',18);
grid on;


clc;clear;
K=5
load(['FCdegreeAndMS\model\steady\',num2str(K),'\FCdegree_MS.mat'])
FC_model_degree=model_FC_degree2;

%%Fit:
[x,order]=sort(FC_model_degree)
y=ms(order)

P= polyfit(x, y, 2)   
yi= polyval(P, x);  
subplot(2,5,8)
plot(x,y,'.k','markersize',18);
% hold on
% plot(x,yi,'r-');
% text(13,0.2,"F=36.4  p=1.52e-14 Adjusted R^2=0.224");
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

% set(gca,'xtick',(12:2:18),'ytick',(0:.1:0.22))
set(gca,'xtick',(12:2:18),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([12 18]);
% ylim([0 0.22])
ylim([0.02 0.22])
ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'sFC degree','FontName','Arial','FontSize',18);
title('Homeostatic K=5','FontName','Arial','FontSize',18);
grid on;



clc;clear;
K=10
load(['FCdegreeAndMS\model\steady\',num2str(K),'\FCdegree_MS.mat'])
FC_model_degree=model_FC_degree2;

[x,order]=sort(FC_model_degree)
y=ms(order)

P= polyfit(x, y, 2)   
yi= polyval(P, x);  

subplot(2,5,9)
plot(x,y,'.k','markersize',18);
% hold on
% plot(x,yi,'r-');
% text(11,0.2,"F=183  p=3.15e-49 adjusted R^2=0.598");
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

% set(gca,'xtick',(10:2:18),'ytick',(0:.1:0.22))
set(gca,'xtick',(10:2:18),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([10 18]);ylim([0.02 0.22])
ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'sFC degree','FontName','Arial','FontSize',18);
title('Homeostatic K=10','FontName','Arial','FontSize',18);
grid on;
%%
clc;clear;
K=14
load(['FCdegreeAndMS\model\steady\',num2str(K),'\FCdegree_MS.mat'])
FC_model_degree=model_FC_degree2;

[x,order]=sort(FC_model_degree)
y=ms(order)

P= polyfit(x, y,2)   
yi= polyval(P, 8:2:16); 

%U型”关系的稳健性检验  一元二次方程回归 检验
ff=@(beta,x)beta(1).*x.*x+beta(2)*x+beta(3);%根据散点图趋势建立方程
beta0=[P(1),P(2),P(3)];%beta0为b1,b2的初始值。
opt=statset;%创建结构体变量类
opt.Robust='on';%开启回归稳健性方法
nlm1=NonLinearModel.fit(x,y,ff,beta0,'Options',opt)

subplot(2,5,10)
plot(x,y,'.k','markersize',18);
hold on
plot(8:2:16,yi,'r-','linewidth',5);
% text(9,0.2,"F=279  p=1.04e-63 adjusted R^2=0.694");
text(9,0.2,['R^2=0.694' sprintf('\n') 'p=0'],'FontName','Arial','FontSize',18);
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1);

% set(gca,'xtick',(8:2:16),'ytick',(0:.1:0.22))
set(gca,'xtick',(8:2:16),'ytick',(0.02:.04:0.22))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.0f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))

xlim([8 16]);
% ylim([0 0.22])
ylim([0.02 0.22])
ylabel( '$$ \bar r_i $$','FontName','Arial','FontSize',18);
xlabel( 'sFC degree','FontName','Arial','FontSize',18);
title('Homeostatic K=14','FontName','Arial','FontSize',18);
grid on;