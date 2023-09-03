%%HCP100
%% FCdegree AND  MS  关系
%data
clc;clear;
close all;
mkdir('FCdegreeAndMS\data')
%data
load('100subparameter_samesc.mat')
ms=mean(ms_100);
DTI_gunter=DTI_gunter_100_mean2;
FC_DATA_matrix=mean(FC_DATA_matrix_100,3);
%----------------------------------------
data_SC_matrix=DTI_gunter;%output
figure;imagesc(data_SC_matrix);colorbar;
data_FC_matrix=FC_DATA_matrix;%output
figure;imagesc(data_FC_matrix);colorbar;
%1 data MS   DATA FC DEGREE
FC_DATA_degree=sum(FC_DATA_matrix);
[r_data,p_data]=corr(ms',FC_DATA_degree')
save('FCdegreeAndMS\data\FCdegree_MS.mat','data_FC_matrix','FC_DATA_degree','ms_100','ms','r_data','p_data');
%% model
clc;clear;
close all;
mkdir('FCdegreeAndMS\model')
load('100subparameter_samesc.mat')
ms=mean(ms_100);
DTI_gunter=DTI_gunter_100_mean2;
FC_DATA_matrix=mean(FC_DATA_matrix_100,3);
%----------------------------------------
data_SC_matrix=DTI_gunter;%output
figure;imagesc(data_SC_matrix);colorbar;
% MODEL FC(峰值处)
for  K=14 %[0 5 10 14]%0:14
    K
    load(['Numorder1\246neterogeny_ms\',num2str(K),'\modeldataSK.mat'],'DTI_gunter','FC_DATA_matrix','DATA_FC','ms','K','b','model_FC0cell','FCFCsimilarity','ptri1','r2','p2');
    % figure
    fcsim1=mean(FCFCsimilarity,2)';
    fcsims1=std(FCFCsimilarity');
    sub100sim(1,:)=fcsim1;
    [sim binx]=max(fcsim1);
    Tsim(1,1)=b(binx);
    Tsim(2,1)=sim;%均值后 peak
    Tsim(3,1)= fcsims1(binx);% peak 的 标准差

    T= Tsim(1,:);%阈值
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for CX=1:100
        model_FC(:,:,CX)=model_FC0cell{binx,CX};
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for CX=1:100
        sFC=model_FC(:,:,CX);
        sFC=sFC-diag(diag(sFC));
        model_FC_degree(CX,:)=sum(sFC);
    end
    model_FC_degree2=mean(model_FC_degree);
    [r_model,p_model]=corr(ms',model_FC_degree2')

    figure(1)
    plot(model_FC_degree2',ms','.k')
%     mkdir('FCdegreeAndMS\model\',num2str(K));
%     save(['FCdegreeAndMS\model\',num2str(K),'\FCdegree_MS.mat'],'model_FC','T','ms','model_FC_degree','model_FC_degree2','r_model','p_model');
end
%% steady
clc;clear;close all;
mkdir('FCdegreeAndMS\model')
load('100subparameter_samesc.mat')
ms=mean(ms_100);
DTI_gunter=DTI_gunter_100_mean2;
FC_DATA_matrix=mean(FC_DATA_matrix_100,3);
%----------------------------------------
data_SC_matrix=DTI_gunter;%output
figure;imagesc(data_SC_matrix);colorbar;
% MODEL FC(峰值处)
for  K=0:14
    K
    load(['Numorder1\246neterogeny_mssteady\',num2str(K),'\modeldataSK.mat']);
    % figure
    fcsim1=mean(FCFCsimilarity,2)';
    fcsims1=std(FCFCsimilarity');
    sub100sim(1,:)=fcsim1;
    [sim binx]=max(fcsim1);
    Tsim(1,1)=b(binx);
    Tsim(2,1)=sim;%均值后 peak
    Tsim(3,1)= fcsims1(binx);% peak 的 标准差

    T= Tsim(1,:);%阈值
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for CX=1:100
        model_FC(:,:,CX)=model_FC0cell{binx,CX};
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for CX=1:100
        sFC=model_FC(:,:,CX);
        sFC=sFC-diag(diag(sFC));
        model_FC_degree(CX,:)=sum(sFC);
    end
    model_FC_degree2=mean(model_FC_degree);
    [r_model,p_model]=corr(ms',model_FC_degree2')

%     mkdir('FCdegreeAndMS\model\steady\',num2str(K));
%     save(['FCdegreeAndMS\model\steady\',num2str(K),'\FCdegree_MS.mat'],'model_FC','ms','T','model_FC_degree','model_FC_degree2','r_model','p_model');
end