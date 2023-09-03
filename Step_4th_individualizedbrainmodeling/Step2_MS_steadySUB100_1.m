%% individualized
close all;
clc;clear;
%1
load('100subparameter.mat')
%model parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for sub=1:100
    ms=ms_100(sub,:);
    FC_DATA_matrix=FC_DATA_matrix_100(:,:,sub);
    DATA_FC=DATA_FC_uptri{sub,1};
    %%%%%%%%%%%SC 
    W=DTI_gunter_100(:,:,sub);
    W=abs(W-diag(diag(W)));    
    W2=sum(W,2);
    W3=zeros(246,246);
    for q=1:246
        W3(q,:)=W2(q,1);
    end
    SC=W./W3;
    DTI_gunter=SC.*20;
    imagesc(DTI_gunter);
    colorbar;
    pause(2)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K1=0:3:6
    CX=50;
    b=[1.4:0.1:3];
    C1=mean(ms);
    ts=61000;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    model_FC0cell=cell(length(b),CX);
    stand_matrix=ones(246,246);
    %%%%%%%%%%%%%%%%%%%%%%%%
    for m=1:1:length(K1)
        K=K1(1,m)
        for j=1:1:CX
            j
            for t = 1:length(b)
                Tm=-K.*(ms-C1)+b(1,t).* ones(1, 246);
                if min(Tm)<0
                    error
                end
                MSsteady_MAIN
            end
        end
        %--------------------------------
        s=strcat('mkdir Numorder1\sub',num2str(sub),'\246neterogeny_mssteady\',num2str(K));
        system(s);
        save(['Numorder1\sub',num2str(sub),'\246neterogeny_mssteady\',num2str(K),'\modeldataSK.mat'],'DTI_gunter','FC_DATA_matrix','DATA_FC','ms','K','b','model_FC0cell','FCFCsimilarity','ptri1');
    end
end
