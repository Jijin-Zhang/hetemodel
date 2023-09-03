%100 subject  ��֪���� ����
%�������� PMAT ��exl 122��   ��������  Picture Vocabulary(exl 127)
%��������  List Sorting Working memory  (exl 158)
%% HCP ǰ 100 �� subject  ������ģ�ͣ�ms sc��---    sfc efc
%����׼��
close all;
clc;clear;
%%1�����Զ�Ӧ data ms and structure
load('RESTmsse3_ͬ������.mat') %303subject
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
%SUNBJECT  ��286��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ms=RESTMS(MS_index(1:286,:),:);
se=RESTSE(MS_index(1:286,:),:);
ms_subject=SUBJECT2(:,4);

% 2.1ȡHCPǰ 100��
ms_100=ms([1:5 7:94 96:102],:);                     %%  output
ms_100subject=ms_subject([1:5 7:94 96:102],:);       %%  output
se_100=se([1:5 7:94 96:102],:);%%  output
figure
subplot(1,2,1)
imagesc(ms_100);
colorbar;
title('100�����Ե� ms');xlabel('Brain region');ylabel('Subject');
set(gca,'FontSize',14);
subplot(1,2,2)
plot(ms_100','b:');
hold on
plot(mean(ms_100)','r-');
title('100�����Ե� ms');
xlabel('Brain region');ylabel('ms');
set(gca,'FontSize',14);
%%
% mkdir('HCP_Congnitivedata')
% PMAT    A �� penn Matrix Reasoning Test
%  clc;clear;close all;
HCP_workfen=xlsread('HCP_EXCEL��������.xlsx');
PMAT_subject=HCP_workfen(:,1);
PMAT_fen=HCP_workfen(:,122);
%����--���Զ�Ӧ
PMAT=PMAT_fen;%��122��  ���Ե�  PMAT
ms_100subject;
i=0;
for x=1:length(PMAT_subject)
    for y=1:length(ms_100subject)
        if PMAT_subject(x,1) ==ms_100subject(y,1)
            i=i+1;
            PMAT_index(i,1) = x;
            MS_index2(i,1) = y;
            SUBJECT3(i,1) = PMAT_subject(x,1);
            SUBJECT3(i,2) = ms_100subject(y,1);
        end
    end
end
SUBJECT3(:,3) = PMAT_subject(PMAT_index,1);
SUBJECT3(:,4) = ms_100subject(MS_index2);
%-----------------------------------------------
PMAT=PMAT(PMAT_index,1);%
PMAT_subject= PMAT_subject(PMAT_index,1);
save('HCP_Congnitivedata\100PMAT.mat','PMAT','PMAT_subject')
%%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��������     crystalized intelligence picture vocabulary      HCP EXCL  127
%clc;clear;close all;
HCP_workfen=xlsread('HCP_EXCEL��������.xlsx');
Picvocab_subject=HCP_workfen(:,1);
Picvocab_fen=HCP_workfen(:,127);
%����--���Զ�Ӧ
Picvocab=Picvocab_fen;
ms_100subject;
i=0;
for x=1:length(Picvocab_subject)
    for y=1:length(ms_100subject)
        if Picvocab_subject(x,1) ==ms_100subject(y,1)
            i=i+1;
            Picvocab_index(i,1) = x;
            MS_index2(i,1) = y;
            SUBJECT4(i,1) = Picvocab_subject(x,1);
            SUBJECT4(i,2) = ms_100subject(y,1);
        end
    end
end
SUBJECT4(:,3) = Picvocab_subject(Picvocab_index,1);
SUBJECT4(:,4) = ms_100subject(MS_index2);
%-----------------------------------------------
Picvocab=Picvocab(Picvocab_index,1);%
Picvocab_subject= Picvocab_subject(Picvocab_index,1);
Picvocab_MEAN=mean(Picvocab)
Picvocab_STD=std(Picvocab)
min(Picvocab)
max(Picvocab)
save('HCP_Congnitivedata\100Picvocab.mat','Picvocab','Picvocab_subject')
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��������  List Sorting Working memory  (exl 158)
%  clc;clear;close all;
HCP_workfen=xlsread('HCP_EXCEL��������.xlsx');
ListSortingWorkingmemory_subject=HCP_workfen(:,1);
ListSortingWorkingmemory_fen=HCP_workfen(:,158);
%����--���Զ�Ӧ
ListSortingWorkingmemory=ListSortingWorkingmemory_fen;%��122��  ���Ե�  PMAT
ms_100subject;
i=0;
for x=1:length(ListSortingWorkingmemory_subject)
    for y=1:length(ms_100subject)
        if ListSortingWorkingmemory_subject(x,1) ==ms_100subject(y,1)
            i=i+1;
            ListSortingWorkingmemory_index(i,1) = x;
            MS_index2(i,1) = y;
            SUBJECT3(i,1) = ListSortingWorkingmemory_subject(x,1);
            SUBJECT3(i,2) = ms_100subject(y,1);
        end
    end
end
SUBJECT3(:,3) = ListSortingWorkingmemory_subject(ListSortingWorkingmemory_index,1);
SUBJECT3(:,4) = ms_100subject(MS_index2);
%-----------------------------------------------
ListSortingWorkingmemory=ListSortingWorkingmemory(ListSortingWorkingmemory_index,1);%
ListSortingWorkingmemory_subject= ListSortingWorkingmemory_subject(ListSortingWorkingmemory_index,1);
ListSortingWorkingmemory_MEAN=mean(ListSortingWorkingmemory)
ListSortingWorkingmemory_STD=std(ListSortingWorkingmemory)
min(ListSortingWorkingmemory)
max(ListSortingWorkingmemory)

save('HCP_Congnitivedata\100ListSortingWorkingmemory.mat','ListSortingWorkingmemory','ListSortingWorkingmemory_subject')


%% ���
clc;clear;
close all;

load('HCP_Congnitivedata\100PMAT.mat','PMAT','PMAT_subject')
PMAT=PMAT([1:44 46:100],1);
load('HCP_Congnitivedata\100Picvocab.mat','Picvocab','Picvocab_subject')
Picvocab2=Picvocab([1:44 46:100],1);
load('HCP_Congnitivedata\100ListSortingWorkingmemory.mat','ListSortingWorkingmemory','ListSortingWorkingmemory_subject')
ListSortingWorkingmemory2=ListSortingWorkingmemory([1:44 46:100],1);
[r1,p1]=corr(PMAT,Picvocab2)
[r2,p2]=corr(PMAT,ListSortingWorkingmemory2)
[r3,p3]=corr(Picvocab2,ListSortingWorkingmemory2)

%% Fit: simi_model,Picvocab
[xData, yData] = prepareCurveData(Picvocab2,ListSortingWorkingmemory2);
% Set up fittype and options.
ft = fittype( 'poly1' );
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );
% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData,'ob');
legend( h, 'simi_data vs. Picvocab', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
text(100,90,'Person"s r=0.4231 p=0 ','FontSize',14);
set(gca,'FontSize',14);
% Label axes
xlabel( 'Picvocab', 'Interpreter', 'none' );
ylabel( 'ListSortingWorkingmemory', 'Interpreter', 'none' );
grid on
%%
clc;clear;
close all;

load('HCP_Congnitivedata\100PMAT.mat','PMAT','PMAT_subject')
PMAT=PMAT([1:44 46:100],1);
figure(1)
subplot(1,3,1)
plot([1:44 46:100],PMAT)
xlabel('Subject')
ylabel('PMAT')
load('HCP_Congnitivedata\100Picvocab.mat','Picvocab','Picvocab_subject')
subplot(1,3,2)
plot(Picvocab)
xlabel('Subject')
ylabel('Picvocab')
load('HCP_Congnitivedata\100ListSortingWorkingmemory.mat','ListSortingWorkingmemory','ListSortingWorkingmemory_subject')
subplot(1,3,3)
plot(ListSortingWorkingmemory)
xlabel('Subject')
ylabel('Working memory')