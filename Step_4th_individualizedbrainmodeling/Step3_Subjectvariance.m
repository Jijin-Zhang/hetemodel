%% ���Լ�Ĳ���---  ��׼Ϊ HCPǰ100���Ե�ƽ��FC matrix
%data
%(1)100����  ÿ��eFC  ��meaneFC �Ĳ���  ��person correct��
clc;clear;close all;
load('100subparameter.mat','FC_DATA_matrix_100','FC_DATA_sub','DATA_FC_uptri');
%%100subject meanFC matrix
eFC_100MEAN=mean(FC_DATA_matrix_100,3);
figure
imagesc(eFC_100MEAN);colorbar;
title('100 ����ƽ��eFC')
%%100subject meanFC matrix  ������Ԫ��
[H,L]=size(eFC_100MEAN);
rest_vector1=[];
for hang1=1:H;
    for lie1=hang1+1:L;
        A=eFC_100MEAN(hang1,lie1);
        rest_vector1=[rest_vector1,A];
    end
end
eFC_100MEAN_uptri=rest_vector1';                %output
%---------------------------------------------------------------------------
%100subject everyone  FC ������Ԫ��
DATA_FC_uptri;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����
for sub=1:100
    FC_uptri=DATA_FC_uptri{sub,1};
    [R(sub),P(sub)]=corr(eFC_100MEAN_uptri,FC_uptri);
end
save('DataSubjectDifferences.mat','FC_DATA_sub','FC_DATA_matrix_100','eFC_100MEAN','eFC_100MEAN_uptri','DATA_FC_uptri','R','P')
%����  Y ��
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MODEL sc ��ͬ   �̻����Լ�Ĳ���(�� 100eFC��ֵΪ��׼)
%%100����  ÿ��sFC  ��meaneFC �Ĳ���  ��person correct��
%��Ϊ model�ϣ� 100mean SC+GH (���� �����ԣ�MS����̬�����ԣ�SC �й�һ��)-����-��sFC
%sFC  (���    ��ͬT ��Ӧ��ͬ sFC)
%Ҫ ��ѡ�� ���� eFC �� sFC  (��100���� �� ģ�� �ٽ�ʱ��T���ʣ���sFC)
%1.ͬ���ԣ�������%Numorder1
close all;clc;clear;
%data
load('DataSubjectDifferences.mat','eFC_100MEAN','eFC_100MEAN_uptri');%  ��׼
%model
for K=[0 3 6]
    for sub=1:100
        sub
        load(['Numorder1\sub',num2str(sub),'\246neterogeny_ms\',num2str(K),'\modeldataSK.mat']);%model  sFC
        %----��� ���
        data_FC_matrix(:,:,sub)=FC_DATA_matrix;%100 ������ FC
        data_ms(:,:,sub)=ms;
        SC=DTI_gunter;
        %--------------------------------------
        fcsim1=mean(FCFCsimilarity,2)';
        fcsims1=std(FCFCsimilarity');
        sub100_sim(sub,:)=fcsim1;
        
        [sim binx]=max(fcsim1);
        Tsim(1,sub)=b(binx);
        Tsim(2,sub)=sim;%��ֵ�� peak
        Tsim(3,sub)= fcsims1(binx);% peak �� ��׼��
        
        for CX=1:50
            model_FC(:,:,CX)=model_FC0cell{binx,CX};
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        for CX=1:50
            sFC=model_FC(:,:,CX);
            
             [rest_vector1]=uptrielement(sFC);
            sFC_uptri=rest_vector1';                %output
            
           [r(CX),p(CX)]=corr(eFC_100MEAN_uptri,sFC_uptri);   
        end
        R(sub)=mean(r);
        P(sub)=mean(p);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    s=strcat('mkdir SubjectDifferent_model\',num2str(K))
    system(s);
    save(['SubjectDifferent_model\',num2str(K),'\modelSubsFC.mat'],'R','P','Tsim');
end
%%%%%%%%%%%%%%%%%%%%%%------------------------------------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��̬ %Numorder1
close all;clc;clear;
%data
load('DataSubjectDifferences.mat','eFC_100MEAN','eFC_100MEAN_uptri');%  ��׼
%MODEL
for K=[0 3 6]
    for sub=1:1:100
        sub
        load(['Numorder1\sub',num2str(sub),'\246neterogeny_mssteady\',num2str(K),'\modeldataSK.mat']);
        %���
        data_FC_matrix(:,:,sub)=FC_DATA_matrix;%100 ������ FC
        data_ms(:,:,sub)=ms;
        SC=DTI_gunter;
        %-----------------------------------------
        fcsim1=mean(FCFCsimilarity,2)';
        
        %         fcsims1=std(FCFCsimilarity');
        sub100sim(sub,:)=fcsim1;
        
        [sim binx]=max(fcsim1);
        Tsim(1,sub)=b(binx);
        Tsim(2,sub)=sim;%��ֵ�� peak
        
        %         Tsim(3,sub)= fcsims1(binx);% peak �� ��׼��
        for CX=1:50
            model_FC(:,:,CX)=model_FC0cell{binx,CX};
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         tic
        for CX=1:50
            sFC=model_FC(:,:,CX);
            
            [rest_vector1]=uptrielement(sFC);
            sFC_uptri=rest_vector1';                %output
            
            [r(CX),p(CX)]=corr(eFC_100MEAN_uptri,sFC_uptri);
        end
        R(sub)=mean(r);
        P(sub)=mean(p);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    s=strcat('mkdir SubjectDifferent_model\Steady\',num2str(K))
    system(s);
    save(['SubjectDifferent_model\Steady\',num2str(K),'\modelSubsFC.mat'],'R','P','Tsim');
end



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clc;clear;close all;
%data  ylabel
load('DataSubjectDifferences.mat','R','P');
R2=R;                        
K=3
load(['SubjectDifferent_model\',num2str(K),'\modelSubsFC.mat'],'R');
r2=R                         
[rr2,pp2]=corrcoef(r2',R2')
figure(1);
h = plot( r2,R2,'.k');
legend( h, 'simi_data vs. simi_model', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
 text(0.05,0.61,'Person"s r=0.20 p=0.04','FontSize',14); 
%text(0.05,0.61,'Person"s r=0.2543 p=0.0107','FontSize',14); 
set(gca,'FontSize',14);
% Label axes
xlabel( 'simi_model', 'Interpreter', 'none' );
ylabel( 'simi_data', 'Interpreter', 'none' );
grid on
title('K=0');
% title('K=6');


%%
clc;clear;close all;
%data  ylabel
load('DataSubjectDifferences.mat','R','P');
R2=R;                     %([1:8 10:30 32:35 37 39 41:58 60:85 87:100]);
K=6
load(['SubjectDifferent_model\Steady\',num2str(K),'\modelSubsFC.mat'],'R');
r4=R                       %([1:8 10:30 32:35 37 39 41:58 60:85 87:100]);
[rr4,pp4]=corrcoef(r4',R2')

figure(2);
h = plot(r4,R2,'.k');
text(0.12,0.61,'Person"s r=0.3192 p=0.0012 ','FontSize',14); 
set(gca,'FontSize',14);
% Label axes
xlabel( 'simi_model', 'Interpreter', 'none' );
ylabel( 'simi_data', 'Interpreter', 'none' );
grid on
%title('Steady K=0');
 title('Steady K=6');

