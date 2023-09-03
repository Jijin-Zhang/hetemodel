%% 工作记忆  Working memory ACCURACY (exl 248)
clc;clear;close all;
load('resttowmupdata96subparameter_GLM1.mat','restms_96','restse_96', 'restms_96subject','wmms_96','wmse_96', 'wmms_96subject','DTI_gunter_96','DTI_gunter_sub','restFC_DATA_matrix_96','restFC_DATA_sub','restDATA_FC_uptri','wmFC_DATA_matrix_96','WM_FC_DATA_sub','wmDATA_FC_uptri');
HCP_workfen=xlsread('HCP_EXCEL任务评分.xlsx');
WorkingmemoryACCURACY_subject=HCP_workfen(:,1);
WorkingmemoryACCURACY_fen=HCP_workfen(:,248);%  ACCURACY
%——--被试对应
WorkingmemoryACCURACY=WorkingmemoryACCURACY_fen;%第122列  被试的  PMAT
wmms_subject=wmms_96subject;
i=0;
for x=1:length(WorkingmemoryACCURACY_subject)
    for y=1:length(wmms_subject)
        if WorkingmemoryACCURACY_subject(x,1) ==wmms_subject(y,1)
            i=i+1;
            WorkingmemoryACCURACY_index(i,1) = x;
            MS_index2(i,1) = y;
            SUBJECT3(i,1) = WorkingmemoryACCURACY_subject(x,1);
            SUBJECT3(i,2) = wmms_subject(y,1);
        end
    end
end
SUBJECT3(:,3) = WorkingmemoryACCURACY_subject(WorkingmemoryACCURACY_index,1);
SUBJECT3(:,4) =wmms_subject(MS_index2);
%-----------------------------------------------
WorkingmemoryACCURACY=WorkingmemoryACCURACY(WorkingmemoryACCURACY_index,1);%
WorkingmemoryACCURACY_subject= WorkingmemoryACCURACY_subject(WorkingmemoryACCURACY_index,1);

mean(WorkingmemoryACCURACY)
std(WorkingmemoryACCURACY)

save('WorkingmemoryACCURACY.mat','WorkingmemoryACCURACY','WorkingmemoryACCURACY_subject')


%%
%% 工作记忆  Working memory 评分(exl 158)
clc;clear;close all;
load('resttowmupdata96subparameter_GLM1.mat','restms_96','restse_96', 'restms_96subject','wmms_96','wmse_96', 'wmms_96subject','DTI_gunter_96','DTI_gunter_sub','restFC_DATA_matrix_96','restFC_DATA_sub','restDATA_FC_uptri','wmFC_DATA_matrix_96','WM_FC_DATA_sub','wmDATA_FC_uptri');

HCP_workfen=xlsread('HCP_EXCEL任务评分.xlsx');
Workingmemory_subject=HCP_workfen(:,1);
Workingmemory_fen=HCP_workfen(:,158);
%——--被试对应
Workingmemory=Workingmemory_fen;%第122列  被试的  PMAT
wmms_subject=wmms_96subject;
i=0;
for x=1:length(Workingmemory_subject)
    for y=1:length(wmms_subject)
        if Workingmemory_subject(x,1) ==wmms_subject(y,1)
            i=i+1;
            Workingmemory_index(i,1) = x;
            MS_index2(i,1) = y;
            SUBJECT3(i,1) = Workingmemory_subject(x,1);
            SUBJECT3(i,2) = wmms_subject(y,1);
        end
    end
end
SUBJECT3(:,3) = Workingmemory_subject(Workingmemory_index,1);
SUBJECT3(:,4) =wmms_subject(MS_index2);
%-----------------------------------------------
Workingmemory=Workingmemory(Workingmemory_index,1);%
Workingmemory_subject= Workingmemory_subject(Workingmemory_index,1);

mean(Workingmemory)
std(Workingmemory)

save('Workingmemoryfen.mat','Workingmemory','Workingmemory_subject')


