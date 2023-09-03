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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%3）DTI  SC
load('SC_BN246.mat')
SC_subject=Subject';
for sub=1:length(ms_100subject);% 100 subject
    [q(sub) qq]=find(SC_subject==ms_100subject(sub));
end
DTI_gunter_sub=SC_subject(q);%output
for sub=1:100;
    DTI_gunter100(:,:,sub)=SC(:,:,q(sub));
    DTI_gunter100(:,:,sub)=DTI_gunter100(:,:,sub)*0.01*0.01;
    DTI_gunter_100(:,:,sub)=DTI_gunter100(:,:,sub); %output  sc
    % figure
    imagesc(DTI_gunter100(:,:,sub));
    colorbar;
    pause(0.2);
    set(gca,'FontSize',14);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%4)data FC
load('restdataFCsubject.mat', 'subject')
DATA_SUBJECT=subject;% data fc
%%%%%%%%%%%%%%%%%%%%%%%%%%
for sub=1:length(ms_100subject);
    [d(sub),dd]=find(DATA_SUBJECT==ms_100subject(sub));
    DATA_SUBJECT(d(sub))
end
FC_DATA_sub=DATA_SUBJECT(d);
for sub=1:100;
    M=int2str(d(sub));
    load(['ROIsignal\BN_246\sub',M,'.mat'],'ROI_246_RS_novoxmean');
    ROI_246_RS_novoxmean = zscore(ROI_246_RS_novoxmean);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rest_FC(:,:,sub)=corr(ROI_246_RS_novoxmean);%rest FC
    rest_FC(:,:,sub)=abs(rest_FC(:,:,sub));
    rest_FC(:,:,sub) = rest_FC(:,:,sub) -diag(diag(rest_FC(:,:,sub)));
    imagesc(rest_FC(:,:,sub));
    colorbar;
    pause(0.2);
end
%%% --------------------------------------
FC_DATA_matrix_100=abs(rest_FC);%rest FC           %output
for sub=1:100
    FC_DATA_matrix_100_2=FC_DATA_matrix_100(:,:,sub);
    [H,L]=size(FC_DATA_matrix_100_2);
    rest_vector1=[];
    for hang1=1:H;
        for lie1=hang1+1:L;
            A=FC_DATA_matrix_100_2(hang1,lie1);
            rest_vector1=[rest_vector1,A];
        end
    end
    DATA_FC_uptri{sub,1}=rest_vector1';                %output
end
save('100subparameter.mat','ms_100', 'ms_100subject','DTI_gunter_100','DTI_gunter_sub','FC_DATA_matrix_100','FC_DATA_sub','DATA_FC_uptri');


%% 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% group level   100 SC  mean
close all;
clc;clear;
%1 MS
load('100subparameter.mat');
DTI_gunter_100mean =mean((DTI_gunter_100),3);
figure
imagesc(DTI_gunter_100mean);
colorbar;
title('100subject mean structure')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DTI_gunter_meanlink=mean(mean(DTI_gunter_100mean)) %0.0274
DTI_gunter_100_mean2=DTI_gunter_100mean.* 5;
DTI_gunter_meanlink2=mean( mean(DTI_gunter_100_mean2) )%0.1369
figure
imagesc(DTI_gunter_100_mean2);
colorbar;
save('100subparameter_samesc.mat','ms_100', 'ms_100subject','DTI_gunter_100','DTI_gunter_100_mean2','DTI_gunter_sub','FC_DATA_matrix_100','FC_DATA_sub','DATA_FC_uptri');