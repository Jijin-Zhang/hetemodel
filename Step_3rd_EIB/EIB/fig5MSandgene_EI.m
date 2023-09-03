 %% 100   左脑  MS
clc;clear;close all;
%HCP 前100被试
load('100subparameter.mat', 'ms_100')
MS=mean(ms_100);
%gene 表达 左脑
 load('LeftBRAIN_gene_EI_expression_raw.mat')%原始数据
MS_left=MS(1,[Brainorder]) 
 figure
subplot(1,3,1)
plot(MS_left)

subplot(1,3,2)
imagesc(MS_left')
colormap('jet')
colorbar
[ms,order]=sort(MS_left');
data=jet(108)
MS2(order,:)=ms
subplot(1,3,3)
plot(MS2)



%% 验证
if MS2-MS==0
    'noerror'
end
data3(order,:)=data;

data4=ones(246,3).*0.7451;
data4(Brainorder,:)=data3;

 save('BN246_MS100left108.txt','data4','-ASCII')

 
 %% 100
clc;clear;
close all;
%HCP 前100被试  rest MS
load('100subparameter.mat', 'ms_100')
MS=mean(ms_100);

%gene 表达 左脑
  load('LeftBRAIN_gene_EI_expression_raw.mat')%原始数据
MS_left=MS(1,[Brainorder])
E(1,:)=table2array(GRIA1_expression(1,2:end));
E(2,:)=table2array(GRIA2_expression(1,2:end));
E(3,:)=table2array(GRIA3_expression(1,2:end));
E(4,:)=table2array(GRIA4_expression(1,2:end));
E(5,:)=table2array(GRIN1_expression(1,2:end));
E(6,:)=table2array(GRIN2A_expression(1,2:end));
E(7,:)=table2array(GRIN2B_expression(1,2:end));
E(8,:)=table2array(GRIN2C_expression(1,2:end));

I(1,:)=table2array(GABRA1_expression(1,2:end));
I(2,:)=table2array(GABRA2_expression(1,2:end));
I(3,:)=table2array(GABRA3_expression(1,2:end));
I(4,:)=table2array(GABRA4_expression(1,2:end));
I(5,:)=table2array(GABRA5_expression(1,2:end));

I(6,:)=table2array(GABRB1_expression(1,2:end));
I(7,:)=table2array(GABRB2_expression(1,2:end));
I(8,:)=table2array(GABRB3_expression(1,2:end));

I(9,:)=table2array(GABRG1_expression(1,2:end));
I(10,:)=table2array(GABRG2_expression(1,2:end));
I(11,:)=table2array(GABRG3_expression(1,2:end));

E2=sum(E)
I2=sum(I)
[r1,p1]=corrcoef(MS_left',E2')
[r2,p2]=corrcoef(MS_left',I2')
EI=E2./I2;
[r3,p3]=corrcoef(EI',MS_left')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 EI2=(EI-min(EI))./(max(EI)-min(EI))
[r4,p4]=corrcoef(EI2',MS_left') 
















%%
P= polyfit(EI',MS_left', 1);   %1阶多项式拟合

yi= polyval(P, 0.6:0.1:0.9);  %求对应y值


min(MS_left')
max(MS_left')
min( EI')
max( EI')

figure
set(gcf,'color','w'); % 背景设为白色

% clc;clear
subplot(1,2,2)
plot(EI',MS_left','.k','markersize',24);
hold on
plot(0.6:0.1:0.9,yi,'-r','LineWidth',5)
grid on
set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)


% text(0.12,0.65,'pearson"s r=0.5138 p=0','FontName','Arial','FontSize',18)
text(0.7,0.18,['r=0.5138' sprintf('\n') 'p=0'],'FontName','Arial','FontSize',18)

set(gca,'xtick',(0.60:.05:0.85),'ytick',(0.04:0.02:0.18))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.2f'),'yTickLabel',num2str(get(gca,'yTick')','%.2f'))
xlim([0.60 0.85])
% ylim([0.02 0.20]);
ylim([0.04 0.18]);

xlabel( 'E:I ratio', 'Interpreter', 'none','FontName','Arial','FontSize',18);
ylabel( '$$ \bar r_i $$', 'Interpreter', 'none','FontName','Arial','FontSize',18);



 fig6_1=imread('AHBA_EIleft108_L.png');   % 读取图片1
subplot(1,2,1)
imagesc(fig6_1);set(gca,'xtick',[],'xticklabel',[]);set(gca,'ytick',[],'yticklabel',[])
colormap('jet');
caxis([0.60 0.85])
colorbar
%  ch = colorbar('horiz');% 横向坐标轴 
%  box on
xlabel( 'E:I ratio', 'Interpreter', 'none','FontName','Arial','FontSize',18);


%  fig6_2=imread('BN246_MS100left108.png');   % 读取图片1
% subplot(2,2,3)
% % imshow(fig6_2)
% imagesc(fig6_2);set(gca,'xtick',[],'xticklabel',[]);set(gca,'ytick',[],'yticklabel',[])
% colormap('jet');
% caxis([0 0.2])
% %colorbar
%  ch = colorbar('horiz');% 横向坐标轴