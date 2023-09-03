%% To do: within each donor, gene expressions were normalized to Z scores across all cortical regions per gene.
%  求E:1  未归一化 （将原来归一化部分去掉）
%step6
clear;clc;
cd E:\zjj工作\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\Step_3rd_EIB\EIB
Step_2nd_Folder = 'E:\zjj工作\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\Step_3rd_EIB\EIB';
FunctionFolder = [Step_2nd_Folder '\functions'];
DataFolder = [Step_2nd_Folder '\wd_data'];
addpath(genpath(FunctionFolder),DataFolder);
%%XXcalculate z score XX  去除原该部分
load('average_same_sample.mat')
for i = 1:size(average_same_sample,1)
    single_donor_gene_sample = average_same_sample{i};
    temp = single_donor_gene_sample';
    each_gene_acorssROI{i,:} = (temp)';%去除%normalized to Z scores across all cortical regions per gene
end
%%add variable names
load('assign_sample_to_ROI.mat')
load('tbl_average_same_sample.mat')
gene_name = tbl_average_same_sample{1}.Allen_Gene_Symbol;

for i = 1:size(tbl_average_same_sample,1)
    sample2roi = assign_sample_to_ROI{i};
    roi_list_subi = unique(sample2roi.matched_ROI_ID(sample2roi.matched_ROI_ID > 0,:));
    tbl_each_gene_acorssROI{i,:} = [gene_name,array2table(each_gene_acorssROI{i})];

    for j = 1: size(roi_list_subi,1)
        reg_label = roi_list_subi(j)
        tbl_each_gene_acorssROI{i,:}.Properties.VariableNames{1} = ['Allen_Gene_Symbol'];
        tbl_each_gene_acorssROI{i,:}.Properties.VariableNames{j+1} = ['ROI_' sprintf('%03d',reg_label)];
    end
end
%step7
cd E:\zjj工作\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\Step_3rd_EIB\EIB
Step_2nd_Folder = 'E:\zjj工作\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\Step_3rd_EIB\EIB';
FunctionFolder = [Step_2nd_Folder '\functions'];
DataFolder = [Step_2nd_Folder '\wd_data'];
addpath(genpath(FunctionFolder),DataFolder);

% record the ROI owned by each donor
load('assign_sample_to_ROI.mat')
for i = 1:size(assign_sample_to_ROI,1)
    sample2roi = assign_sample_to_ROI{i};
    roi_list_subi = unique(sample2roi.matched_ROI_ID(sample2roi.matched_ROI_ID > 0,:));

    dor_id = repmat(i,size(roi_list_subi));
    temp = array2table(cat(2,roi_list_subi,dor_id),'VariableNames',{'spec_roi_id','sub_id'});
    roi_list_of_each_donor{i} = temp;
end
roi_list_of_each_donor = roi_list_of_each_donor';
roi2sub_list = cat(1, roi_list_of_each_donor{:});
save(fullfile(Step_2nd_Folder,'wd_data','roi2sub_list.mat'),'roi2sub_list')

%% average donors with same ROI
load('roi2sub_list.mat')
load('union_roi_list_in6donors.mat') %union roi list in 6 donors
for j = 1:size(union_roi_list_in6donors,1)
    tbl_gene_corsp_same_roi = [];
    gene_corsp_same_roi = [];
    roi_j = union_roi_list_in6donors(j) %roi id
    sub_id_list = roi2sub_list.sub_id(roi2sub_list.spec_roi_id==roi_j) %find out which donors have roi_j

    for i = 1:size(sub_id_list,1)
        if size(sub_id_list,1) == 1
            single_sub_id = sub_id_list
        else
            single_sub_id = sub_id_list(i)
        end
        complte_gene_exp =  tbl_each_gene_acorssROI{single_sub_id};
        name = ['ROI_' sprintf('%03d',roi_j)];%variable names
        tbl_gene_corsp_same_roi{i} = complte_gene_exp(:,strcmp(complte_gene_exp.Properties.VariableNames,name)==1);%extract the column where roi_j is located
        gene_corsp_same_roi{i} = table2array(complte_gene_exp(:,strcmp(complte_gene_exp.Properties.VariableNames,name)==1));
    end
    combine_roi_j_across_donors = cell2mat(gene_corsp_same_roi);
    average_6donors_grouplevel_expression(:,j) = mean(combine_roi_j_across_donors,2);
end
%%add variable names
% load('tbl_normalized_each_gene_acorssROI.mat')
gene_name = tbl_each_gene_acorssROI{1}.Allen_Gene_Symbol;

tbl_average_6donors_grouplevel_expression = [gene_name,array2table(average_6donors_grouplevel_expression)];
for j = 1: size(union_roi_list_in6donors,1)
    reg_label = union_roi_list_in6donors(j)
    tbl_average_6donors_grouplevel_expression.Properties.VariableNames{1} = ['Allen_Gene_Symbol'];
    tbl_average_6donors_grouplevel_expression.Properties.VariableNames{j+1} = ['ROI_' sprintf('%03d',reg_label)];
end
save(fullfile(Step_2nd_Folder,'wd_data','tbl_average_6donors_grouplevel_expression_raw.mat'),'tbl_average_6donors_grouplevel_expression')

%%
clc;clear;close all;
%从中提取出 AMPA  和NMDDA 相关兴奋性基因（E） 4 +4  8
%从中提取出 GABAA 相关抑制性基因（I） 11
Step_2nd_Folder = 'E:\zjj工作\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\Step_3rd_EIB\EIB';
FunctionFolder = [Step_2nd_Folder '\functions'];
DataFolder = [Step_2nd_Folder '\wd_data'];
addpath(genpath(FunctionFolder),DataFolder);
%
load('union_roi_list_in6donors.mat', 'union_roi_list_in6donors')%脑区编号
load('tbl_average_6donors_grouplevel_expression_raw.mat')
Brainorder=union_roi_list_in6donors;
%%AMPA
GRIA1_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GRIA1'),:);
GRIA2_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GRIA2'),:);
GRIA3_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GRIA3'),:);
GRIA4_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GRIA4'),:);
%%NMDA
GRIN1_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GRIN1'),:);
GRIN2A_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GRIN2A'),:);
GRIN2B_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GRIN2B'),:);
GRIN2C_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GRIN2C'),:);
%%GABA_A
GABRA1_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRA1'),:);
GABRA2_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRA2'),:);
GABRA3_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRA3'),:);
GABRA4_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRA4'),:);
GABRA5_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRA5'),:);

GABRB1_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRB1'),:);
GABRB2_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRB2'),:);
GABRB3_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRB3'),:);

GABRG1_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRG1'),:);
GABRG2_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRG2'),:);
GABRG3_expression= tbl_average_6donors_grouplevel_expression(strcmp(tbl_average_6donors_grouplevel_expression.Allen_Gene_Symbol,'GABRG3'),:);
clear DataFolder  DataFolder   tbl_average_6donors_grouplevel_expression
 save(fullfile(Step_2nd_Folder,'wd_data','LeftBRAIN_gene_EI_expression_raw.mat'))



