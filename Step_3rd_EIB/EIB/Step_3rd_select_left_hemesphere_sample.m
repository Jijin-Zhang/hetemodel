%% To do: select samples located in left hemisphere according to the sample annotation in SampleAnnot.csv.
%左脑
clear

cd E:\zjj工作\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\Step_3rd_EIB\EIB
Step_2nd_Folder = 'E:\zjj工作\Heterogeneouslargescalebrainnetworksimulationbasedonneuralsynchronousactivityinbrainregions\Step_3rd_EIB\EIB';
FunctionFolder = [Step_2nd_Folder '\functions'];
addpath(genpath(FunctionFolder));

% load SampleAnnot file
dornor_list = kb_ls(fullfile(Step_2nd_Folder,'raw_gene','combined_data','H*'))
for i=1:size(dornor_list,1)
        SampleAnnot = readtable(fullfile(dornor_list{i},'SampleAnnot.csv'),'Encoding', 'UTF-8');% 'gene',
        SampleAnnot = SampleAnnot(:,[11,12,13,5,6]); % keep only MNI and annot name
        SampleAnnot.sample_id = [1:size(SampleAnnot,1)]';
        SampleAnnot_only_left{i} = SampleAnnot(find(contains(SampleAnnot{:,5},'left')==1),:); 
end
SampleAnnot_only_left = SampleAnnot_only_left';
save(fullfile(Step_2nd_Folder,'wd_data','SampleAnnot_only_left.mat'), 'SampleAnnot_only_left');





