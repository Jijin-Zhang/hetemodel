%% HCP ǰ96�� subject  ������ģ�ͣ�ms sc��---    sfc efc
%����׼��
close all;
clc;clear;
%%1�����Զ�Ӧ data ms and structure
load('RESTmsse3_ͬ������.mat') %303subject    cd:G:\Ghģ��\246����   ͬ�����챻�Ե�MSSE\246 rest_msseͬ���챻��\
restMS_SUBJECT=SUBJECT;             %ms
load('SC_BN246.mat','Subject','SC');%287subject
structure_subject=Subject';   %DTI
%------------------------------------------------
sub=0;
for x=1:length(structure_subject);
    for y=1:length(restMS_SUBJECT);
        if structure_subject(x,1) ==restMS_SUBJECT(y,1);
            sub=sub+1;
            SC_index(sub,1) = x;
            restMS_index(sub,1) = y;
            SUBJECT2(sub,1) = structure_subject(x,1);
            SUBJECT2(sub,2) = restMS_SUBJECT(y,1);
        end
    end
    
end
SUBJECT2(:,3) = structure_subject(SC_index(1:286,:));%SUBJECT 1 STRUCTURE
SUBJECT2(:,4) = restMS_SUBJECT(restMS_index(1:286,:));%SUBJECT 2 MS
%SUNBJECT  ��286��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
restms=RESTMS(restMS_index(1:286,:),:);
restse=RESTSE(restMS_index(1:286,:),:);
restms_subject=SUBJECT2(:,4);

% 2.1ȡHCPǰ 100��
restms_100=restms([1:5 7:94 96:102],:);                     %%  output
restms_100subject=restms_subject([1:5 7:94 96:102],:);       %%  output
restse_100=restse([1:5 7:94 96:102],:);%%  output
%%%96SUBJECT
restms_96=restms_100([1:42 44:76 78:93 95:98 100],:);                     %%  output
restms_96subject=restms_100subject([1:42 44:76 78:93 95:98 100],:);       %%  output
restse_96=restse_100([1:42 44:76 78:93 95:98 100],:);%%  output

figure
subplot(1,2,1)
imagesc(restms_96);
colorbar;
title('96�����Ե� rst ms');xlabel('Brain region');ylabel('Subject');
set(gca,'FontSize',14);
subplot(1,2,2)
plot(restms_96','b:');
hold on
plot(mean(restms_96)','r-');
title('96�����Ե� rest ms');
xlabel('Brain region');ylabel('rest ms');
set(gca,'FontSize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%WM MS
  load('WMmsse_glm_ͬ������1.mat')
WM_subject=wmsubject;
for sub=1:length(restms_96subject);% 100 subject
    [q(sub) qq]=find(WM_subject==restms_96subject(sub));
end
wmms_96subject=WM_subject(q);%output
wmms_96=WMsyn(q,:);                     %%  output
wmse_96=WMsynE(q,:);                     %%  output

figure
plot(mean(restms_96)','r-');
hold on
plot(mean(wmms_96),'b-');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%3��DTI  SC
load('SC_BN246.mat')
SC_subject=Subject';
for sub=1:length(restms_96subject);% 97 subject
    [q(sub) qq]=find(SC_subject==restms_96subject(sub));
end
DTI_gunter_sub=SC_subject(q);%output
for sub=1:96;
    DTI_gunter96(:,:,sub)=SC(:,:,q(sub));
    DTI_gunter96(:,:,sub)=DTI_gunter96(:,:,sub)*0.01*0.01;
    DTI_gunter_96(:,:,sub)=DTI_gunter96(:,:,sub); %output  sc
    % figure
    imagesc(DTI_gunter96(:,:,sub));
    colorbar;
    pause(0.2);
    set(gca,'FontSize',14);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%4)�����ϵõ���REST FC
load('E:\zjj����\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\step_6th_modelworkingmemory\96subjectwmmean20220924cx1000\subject.mat', 'subject')
restDATA_SUBJECT=subject;% data fc
%%%%%%%%%%%%%%%%%%%%%%%%%%
for sub=1:length(restms_96subject);  %100 ����
    [d(sub),dd]=find(restDATA_SUBJECT==restms_96subject(sub));
    restDATA_SUBJECT(d(sub))
end
restFC_DATA_sub=restDATA_SUBJECT(d);
for sub=1:96;
    M=int2str(d(sub));%�����ݸ�ʽת��Ϊ�ַ�
    load(['E:\zjj����\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\step_6th_modelworkingmemory\96subjectwmmean20220924cx1000\ROIsignal\BN_246\sub',M,'.mat'],'ROI_246_RS_novoxmean');
    ROI_246_RS_novoxmean = zscore(ROI_246_RS_novoxmean);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rest_FC(:,:,sub)=corr(ROI_246_RS_novoxmean);%rest FC����
    rest_FC(:,:,sub)=abs(rest_FC(:,:,sub));
    rest_FC(:,:,sub) = rest_FC(:,:,sub) -diag(diag(rest_FC(:,:,sub))); %  A-diag(diag(A))����
    imagesc(rest_FC(:,:,sub));
    colorbar;
    pause(0.2);
end
%%% --------------------------------------
restFC_DATA_matrix_96=abs(rest_FC);%rest FC����           %output
for sub=1:96
    FC_DATA_matrix_96_2=restFC_DATA_matrix_96(:,:,sub);
    [rest_vector1]=uptrielement(FC_DATA_matrix_96_2);
    restDATA_FC_uptri{sub,1}=rest_vector1';                %output
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4)�����ϵõ���WM FC
% data fc
WM_FC_DATA_sub=restms_96subject;
for sub=1:96;
    M=int2str(restms_96subject(sub));%�����ݸ�ʽת��Ϊ�ַ�;    
    load(['E:\zjj����\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\step_6th_modelworkingmemory\96subjectwmmean20220924cx1000\WM_ROI_signals_glm1\BN_246\',M,'\work_BN246_ROI.mat'])
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    work_BN246_ROI= zscore(work_BN246_ROI);
    wm_FC(:,:,sub)=corr(work_BN246_ROI);%wm FC����
    wm_FC(:,:,sub)=abs(wm_FC(:,:,sub));
    wm_FC(:,:,sub) = wm_FC(:,:,sub) -diag(diag(wm_FC(:,:,sub))); %  A-diag(diag(A))����
    imagesc(wm_FC(:,:,sub));
    colorbar;
    pause(0.2);
end
%%% --------------------------------------
wmFC_DATA_matrix_96=abs(wm_FC);          %output
for sub=1:96
    wmFC_DATA_matrix_96_2=wmFC_DATA_matrix_96(:,:,sub);
    wm_vector1=uptrielement(wmFC_DATA_matrix_96_2);
    wmDATA_FC_uptri{sub,1}=wm_vector1';                %output
end
% save('resttowmupdata96subparameter_GLM1.mat','restms_96','restse_96', 'restms_96subject','wmms_96','wmse_96', 'wmms_96subject','DTI_gunter_96','DTI_gunter_sub','restFC_DATA_matrix_96','restFC_DATA_sub','restDATA_FC_uptri','wmFC_DATA_matrix_96','WM_FC_DATA_sub','wmDATA_FC_uptri');


% 96����  rest FC  to  WM  FC   updata
%%
clc;clear;close all;
load('resttowmupdata96subparameter_GLM1.mat')
figure
subplot(1,3,1)
plot(mean(wmms_96,1),'-b')
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}WM MS')
title('\fontname{Aria}96��������ˮƽ��ƽ��WM MS')
set(gca,'FontSize',14);grid on
ylim([0.05 0.22])
subplot(1,3,2)
plot(mean(wmse_96,1),'-b')
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}WM SE')
title('\fontname{Aria}96��������ˮƽ��ƽ��WM SE')
set(gca,'FontSize',14);grid on 
subplot(1,3,3)
 plot(mean(wmms_96,1), mean(wmse_96,1),'.K' );
 title('\fontname{Aria}96��������ˮƽ��ƽ�� WM SE WMMS')
% Label axes
xlabel('\fontname{Aria}WM MS')
ylabel ('\fontname{Aria}WM SE')
set(gca,'FontSize',14);grid on
%
figure
subplot(1,3,1)
plot(mean(restms_96,1),'-b')
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}Rest MS')
title('\fontname{Aria}96��������ˮƽ��ƽ��Rest MS')
set(gca,'FontSize',14);grid on
ylim([0.05 0.22])
subplot(1,3,2)
plot(mean(restse_96,1),'-b')
xlabel('\fontname{Aria}Brain');ylabel('\fontname{Aria}Rest SE')
title('\fontname{Aria}96��������ˮƽ��ƽ��Rest SE')
set(gca,'FontSize',14);grid on 
subplot(1,3,3)
 plot(mean(restms_96,1), mean(restse_96,1),'.K' );
xlabel('\fontname{Aria}Rest MS')
ylabel ('\fontname{Aria}Rest SE')
set(gca,'FontSize',14);grid on