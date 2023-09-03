%% individualized
close all;
clc;clear;
load('100subparameter.mat')
%model parameters
%%%%   %%%%%%%%%%%%%%%%%%%%%%%%%%
tic
for sub=1:100
    ms=ms_100(sub,:);
    FC_DATA_matrix=FC_DATA_matrix_100(:,:,sub);
    DATA_FC=DATA_FC_uptri{sub,1};
    DTI_gunter=DTI_gunter_100(:,:,sub);
    DTI_gunter=DTI_gunter.*5;
    imagesc(DTI_gunter);
    colorbar;
    pause(2)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %parameter
    K1=0:3:6
    b=[1.4:0.1:1.8 2:0.1:2.5 2.7 2.9:0.1:3.5 3.7 4];
    CX=50;
    C1=mean(ms);
    ts=61000;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %      model_FC0cell=cell(length(b),CX);
    stand_matrix=ones(246,246);
    for m=1:1:length(K1)
        K=K1(1,m)
        for j=1:1:CX
            j
            for t = 1:length(b)
                Tm=-K.*(ms-C1)+b(1,t).* ones(1, 246);
                if min(Tm)<0
                    error
                end
                MS_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder1\sub',num2str(sub),'\246neterogeny_ms\',num2str(K));
        system(s);
        save(['Numorder1\sub',num2str(sub),'\246neterogeny_ms\',num2str(K),'\modeldataSK.mat'],'DTI_gunter','FC_DATA_matrix','DATA_FC','ms','K','b','model_FC0cell','FCFCsimilarity','ptri1');
    end
end
toc
