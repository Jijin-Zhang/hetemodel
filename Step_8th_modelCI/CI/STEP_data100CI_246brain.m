%Data preparation  HCP 100 SUBJECTS
%% 1 Find data(SC FC MS)on 100 subjects
close all;
clc;clear;
%%1）data ms and structure  order
load('RESTmsse3_同脑异人.mat') %303subject
MS_SUBJECT=SUBJECT;             %ms
load('SC_BN246.mat','Subject','SC');%287subject
structure_subject=Subject';   %DTI
%------------------------------------------------
sub=0;
for x=1:length(structure_subject);
    for y=1:length(MS_SUBJECT);
        if structure_subject(x,1) ==MS_SUBJECT(y,1);
            sub=sub+1;
            SC_index(sub,1) = x;
            MS_index(sub,1) = y;
            SUBJECT2(sub,1) = structure_subject(x,1);
            SUBJECT2(sub,2) = MS_SUBJECT(y,1);
        end
    end
end
SUBJECT2(:,3) = structure_subject(SC_index(1:286,:));%SUBJECT 1 STRUCTURE
SUBJECT2(:,4) = MS_SUBJECT(MS_index(1:286,:));%SUBJECT 2 MS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ms=RESTMS(MS_index(1:286,:),:);
se=RESTSE(MS_index(1:286,:),:);
ms_subject=SUBJECT2(:,4);
% 2.1 HCP 100 subject
%Abnormal subjects were removed
ms_100=ms([1:5 7:94 96:102],:);                     %%  output
ms_100subject=ms_subject([1:5 7:94 96:102],:);       %%  output
se_100=se([1:5 7:94 96:102],:);                       %%  output
figure
subplot(1,2,1)
imagesc(ms_100);
colorbar;
title('100个被试的 ms');xlabel('Brain region');ylabel('Subject');
set(gca,'FontSize',14);
subplot(1,2,2)
plot(ms_100','b:');
hold on
plot(mean(ms_100)','r-');
title('100个被试的 ms');
xlabel('Brain region');ylabel('ms');
set(gca,'FontSize',14);
save('ms_100.mat','ms_100subject','ms_100')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
close all;
load('ms_100.mat','ms_100subject','ms_100')
%%4)data FC
load('restdataFCsubject.mat', 'subject')
DATA_SUBJECT=subject;% data fc
%%%%%%%%%%%%%%%%%%%%%%%%%%
for sub=1:length(ms_100subject);
    [d(sub),dd]=find(DATA_SUBJECT==ms_100subject(sub));
    DATA_SUBJECT(d(sub))
end
FC_DATA_sub=DATA_SUBJECT(d);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
for sub=1%1:100;
    M=int2str(d(sub));
    load(['ROIsignal\BN_246\sub',M,'.mat'],'ROI_246_RS_novoxmean');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % z-score normalized signals
    signals=ROI_246_RS_novoxmean;
    signals_zs = zscore(signals);
figure(1)
subplot(2,1,1)
plot(signals_zs(:,1),'-b')
title('sub1 brain1 normalized BOLD ')
subplot(2,1,2)
plot(signals(:,1:246))
title('sub1 brain1-246 BOLD')
    %calculate the kuramoto parameter
    kop = xlz_kop(signals_zs');
[r, kop_complex] = xlz_kop(signals_zs')
    %%
    figure(2)
plot(kop)
title('KOP')
    KOP2=kop';
    bins_num = 30;
    [MS, SS, CS, SE, sample_failed] =  xlz_kop2sta(kop, bins_num);
    kop_sta_BN246(sub).kop = kop;
    kop_sta_BN246(sub).mean_kop = MS;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %calculate the A OF BOLD
    SIGNALS=signals_zs';
    [ele_num, time_num] = size(SIGNALS);
    % obtain the instaneouse phase
    for NN = 1 : ele_num
        a_s(NN,:) = hilbert(SIGNALS(NN,:)); %analytical signals
        theta(NN,:) = angle(a_s(NN,:));% instaneouse phases
        amplitude(NN,:) = abs(a_s(NN,:));
    end
figure(3)
subplot(3,1,1)
plot(SIGNALS(1,:))
xlabel('Time point');%ylabel()
title('脑区1 BOLD')
%   subplot(4,1,2)
%   feather(a_s(1,:))
%    title('希尔伯特变换后的解析信号')
subplot(3,1,2)
plot(theta(1,:))
title('瞬时相位')
subplot(3,1,3)
plot(amplitude(1,:))
title('瞬时振幅')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %calculate the CI
    for seed=1:246
        X=amplitude(seed,1:1200);
        XX=[X;kop];
        N=size(XX,1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        NLags=10*ones(N,N);
        [CI1{seed}] = pair_granger_norm(XX,NLags);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ITER=1200;
        [CI2{seed},GCr{seed},Pval{seed}] = ndte_example_surrogates_fixlags_cs(XX,ITER);
    end
%     s=strcat('mkdir DATA\246CI\sub',num2str(sub));
%     system(s);
%     save(['DATA\246CI\sub',num2str(sub),'\dataci.mat'],'KOP2','MS','SE','CI1','CI2','GCr','Pval');
end
toc















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  将100个被试 按同步大小排序 
clc;clear;
close all;
for sub=1:100
load(['DATA\246CI\sub',num2str(sub),'\dataci.mat'])
MS_100(sub,1)=MS;
SE_100(sub,1)=SE;
end
figure
plot(MS_100,SE_100,'OK')
%%%%%%%%%%%%%%
[x,order]=sort(MS_100)
y=SE_100(order)


figure
set(gcf,'color','w');

P= polyfit(x, y, 2)
yi= polyval(P, [0:0.01:1]);

%U型”关系的稳健性检验  一元二次方程回归 检验
ff=@(beta,x)beta(1).*x.*x+beta(2)*x+beta(3);%根据散点图趋势建立方程
beta0=[P(1),P(2),P(3)];%beta0为b1,b2的初始值。
opt=statset;%创建结构体变量类
opt.Robust='on';%开启回归稳健性方法
nlm1=NonLinearModel.fit(x,y,ff,beta0,'Options',opt)

plot(x,y,'.k','markersize',18);
hold on
plot([0:0.01:1],yi,'r-','linewidth',5);

set(gca,'FontName','Arial','FontSize',14,'LineWidth',1)

% text(0.2,4.7,"F=62  p=4.42e-52 Adjusted R^2=0.552");
text(0.2,4.7,['R^2=0.552' sprintf('\n') 'p=0'],'FontName','Arial','FontSize',18);


set(gca,'xtick',(0.1:0.1:0.7),'ytick',(4.1:.1:4.8))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.1f'),'yTickLabel',num2str(get(gca,'yTick')','%.1f'))

xlim([0.1 0.6]);
ylim([4.1 4.8])
ylabel( 'SE','FontName','Arial','FontSize',18);
xlabel( 'MS','FontName','Arial','FontSize',18);
grid on
title('Data 100','FontName','Arial','FontSize',18)
%
MS_100submin=MS_100(order(1:25),1)
MS_100submed=MS_100(order(50-12:50+12),1)
MS_100submax=MS_100(order(76:100),1)

%data CI
 %SUBJECT=order(1:25,1);
% SUBJECT=order(50-12:50+12,1);
% SUBJECT=order(76:100,1);
%SUBJECT=order(1:10,1);
 SUBJECT=order(91:100,1);

for SUB1=1:length(SUBJECT)
    sub=SUBJECT(SUB1,1)
    load(['DATA\246CI\sub',num2str(sub),'\dataci.mat'],'KOP2','MS','SE','CI1','CI2','GCr','Pval');
    MS_SUB(sub,1)=MS;
    SE_SUB(sub,1)=SE;
    if MS==mean(KOP2)

        for roi=1:246
            CI_data_roi1=CI1(roi);
            CI_data_roi1=CI_data_roi1{1,1};
            CI_data1(roi,1)=CI_data_roi1(2,1);
        end
        %         CI_data1=zscore(CI_data1);

        CI_data11(:,sub)=CI_data1;
        figure(1)
        plot(CI_data11(:,sub))
        xlabel('Brain')
        ylabel('CI')
        title('Sub1')
        for roi=1:246
            CI_data_roi2=CI2(roi);
            CI_data_roi2=CI_data_roi2{1,1};
            CI_data2(roi,1)=CI_data_roi2(2,1);
        end
        %         CI_data2=zscore(CI_data2);

        CI_data22(:,sub)=CI_data2;

    else
        'error'
    end
end
%组水平
mean(CI_data11,1)

dataCI1=mean(CI_data11,2);
dataCI2=mean(CI_data22,2);

figure(2)
subplot(2,1,1)
plot(CI_data11)
xlabel('Brain')
ylabel('CI')
subplot(2,1,2)
plot(dataCI1)
xlabel('Brain')
ylabel('CI')
title('组水平')

figure(3)
plot(CI_data11,'b')
hold on
plot(dataCI1,'r')

mean(dataCI1)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 将100个被试 按脑区同步mean大小排序
clc;clear;
close all;
load('100subparameter_samesc.mat', 'ms_100')

for sub=1:100
MS_100mean(sub,1)=mean(ms_100(sub,:));
end
figure
plot(MS_100mean,'-OK')
xlabel('Subject')
ylabel('脑区同步分布的均值')
%%%%%%%%%%%%%%
[x,order]=sort(MS_100mean)


  %SUBJECT=order(1:25,1);
 %SUBJECT=order(50-12:50+12,1);
 %  SUBJECT=order(76:100,1);
 %SUBJECT=order(91:100,1);
   % SUBJECT=order(1:10,1);
 %  SUBJECT=order(46:55,1);
  SUBJECT=order(61:70,1);  
SUBJECT=order(1:100,1);  
figure
plot(ms_100(SUBJECT,:)','-b')
hold on
plot(mean(ms_100(SUBJECT,:)',2),'-r')
mean(mean(ms_100(SUBJECT,:)',2))
xlabel('Brain')
ylabel('脑区同步值')
 %title('1-25sub mean min')
% title('38-62sub mean med')
 %title('76-100sub mean max')
%   title('91-100sub mean max')
 % title('1-10sub mean min')
  title('46-55sub mean med')
%
for SUB1=1:length(SUBJECT)
    sub=SUBJECT(SUB1,1)
    load(['DATA\246CI\sub',num2str(sub),'\dataci.mat'],'KOP2','MS','SE','CI1','CI2','GCr','Pval');
    MS_SUB(sub,1)=MS;
    SE_SUB(sub,1)=SE;
    if MS==mean(KOP2)

        for roi=1:246
            CI_data_roi1=CI1(roi);
            CI_data_roi1=CI_data_roi1{1,1};
            CI_data1(roi,1)=CI_data_roi1(2,1);
        end
        CI_data11(:,sub)=CI_data1;
        figure(1)
        plot(CI_data11(:,sub))
        xlabel('Brain')
        ylabel('CI')
        title('Sub1')
        for roi=1:246
            CI_data_roi2=CI2(roi);
            CI_data_roi2=CI_data_roi2{1,1};
            CI_data2(roi,1)=CI_data_roi2(2,1);
        end
          CI_data22(:,sub)=CI_data2;

    else
        'error'
    end
end

mean(CI_data11,1);
%% 组水平
dataCI1=mean(CI_data11,2);
dataCI2=mean(CI_data22,2);

figure(2)
subplot(2,1,1)
plot(CI_data11)
xlabel('Brain')
ylabel('CI')
subplot(2,1,2)
plot(dataCI1)

xlabel('Brain')
ylabel('CI')
 %title('1-25 组水平')
%title('38-62 组水平')
%  title('76-100 组水平')
% title('91-100 组水平')
 %title('1-10 组水平')
title('46-55 组水平')
mean(dataCI1)










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  3  将100个被试 按脑区同步方差大小排序
clc;clear;
close all;
load('100subparameter_samesc.mat', 'ms_100')

for sub=1:100
MS_100var(sub,1)=var(ms_100(sub,:));
end
figure
plot(MS_100var,'-OK')
xlabel('Subject')
ylabel('脑区同步分布的方差')
%%%%%%%%%%%%%%
[x,order]=sort(MS_100var)


 %SUBJECT=order(1:25,1);
 % SUBJECT=order(50-12:50+12,1);
%  SUBJECT=order(76:100,1);
%  SUBJECT=order(91:100,1);
%   SUBJECT=order(1:10,1);
   SUBJECT=order(46:55,1);

  SUBJECT=order(61:70,1);  
figure
plot(ms_100(SUBJECT,:)','-b')
hold on
plot(mean(ms_100(SUBJECT,:)',2),'-r')
mean(mean(ms_100(SUBJECT,:)',2))
xlabel('Brain')
ylabel('脑区同步值')
 %title('1-25sub Var min')
% title('38-62sub Var med')
% title('76-100sub Var max')
%  title('91-100sub Var max')
%   title('1-10sub Var min')
  title('46-55sub Var med')
%
for SUB1=1:length(SUBJECT)
    sub=SUBJECT(SUB1,1)
    load(['DATA\246CI\sub',num2str(sub),'\dataci.mat'],'KOP2','MS','SE','CI1','CI2','GCr','Pval');
    MS_SUB(sub,1)=MS;
    SE_SUB(sub,1)=SE;
    if MS==mean(KOP2)

        for roi=1:246
            CI_data_roi1=CI1(roi);
            CI_data_roi1=CI_data_roi1{1,1};
            CI_data1(roi,1)=CI_data_roi1(2,1);
        end
        CI_data11(:,sub)=CI_data1;
        figure(1)
        plot(CI_data11(:,sub))
        xlabel('Brain')
        ylabel('CI')
        title('Sub1')
        for roi=1:246
            CI_data_roi2=CI2(roi);
            CI_data_roi2=CI_data_roi2{1,1};
            CI_data2(roi,1)=CI_data_roi2(2,1);
        end
          CI_data22(:,sub)=CI_data2;

    else
        'error'
    end
end

mean(CI_data11,1);
%组水平
dataCI1=mean(CI_data11,2);
dataCI2=mean(CI_data22,2);

figure(2)
subplot(2,1,1)
plot(CI_data11)
xlabel('Brain')
ylabel('CI')
subplot(2,1,2)
plot(dataCI1)

xlabel('Brain')
ylabel('CI')
%title('1-25 组水平')
 %title('38-62 组水平')
%  title('76-100 组水平')
% title('91-100 组水平')
% title('1-10 组水平')
title('46-55 组水平')
mean(dataCI1)
