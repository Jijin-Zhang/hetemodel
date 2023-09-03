%CI fit
clc;clear;
close all;
%data CI
for sub=1:100
    load(['DATA\246CI\sub',num2str(sub),'\dataci.mat'],'KOP2','MS','SE','CI1','CI2','GCr','Pval');
    MS_SUB(sub,1)=MS;
    SE_SUB(sub,1)=SE;
    if MS==mean(KOP2)

        for roi=1:246
            CI_data_roi1=CI1(roi);
            CI_data_roi1=CI_data_roi1{1,1};
            CI_data1(roi,1)=CI_data_roi1(2,1);
        end
       
        CI_data11(:,sub)=CI_data1;
        figure(1)
        plot(CI_data11(:,sub))
        xlabel('Brain')
        ylabel('CI')
        title('Sub1')
        for roi=1:246
            CI_data_roi2=CI2(roi);
            CI_data_roi2=CI_data_roi2{1,1};
            CI_data2(roi,1)=CI_data_roi2(2,1);
        end
       
        CI_data22(:,sub)=CI_data2;

    else
        'error'
    end
end
%组水平
dataCI1=mean(CI_data11,2);
dataCI2=mean(CI_data22,2);

figure(2)
subplot(2,1,1)
plot(CI_data11)
xlabel('Brain')
ylabel('CI')
subplot(2,1,2)
plot(dataCI1)
xlabel('Brain')
ylabel('CI')
title('组水平')

figure(3)
plot(CI_data11,'b')
hold on
plot(dataCI1,'r')

figure(4)
plot(MS_SUB,SE_SUB,'OB')
save('DataCI.mat','CI_data11','dataCI1','CI_data22','dataCI2','MS_SUB','SE_SUB')

%% model
clc;clear;
close all;
kk=0;
for K=[14]
    kk=kk+1;
    for j=1:100
        load(['MODEL\246CI\',num2str(K),'\CX',num2str(j),'\modeldataCI.mat'],'K','b','kop','MS','SE','CI_model');
        MS_MODEL(j,1)=MS;
        SE_MODEL(j,1)=SE;

        if MS==mean(kop)

            for roi=1:246
                CI_model_roi1=CI_model(roi);
                CI_model_roi1=CI_model_roi1{1,1};
                CI_model1(roi,1)=CI_model_roi1(2,1);

            end
            % CI_model1=zscore(CI_model1);

            CI_model11(:,j)=CI_model1;
        else
            'error'
        end

    end
    modelCI1=mean(CI_model11,2);


    figure(2)
    subplot(2,1,1)
    plot(CI_model11)
    xlabel('Brain')
    ylabel('CI')
    title('重复100次 K=14')
    subplot(2,1,2)
    plot(modelCI1)
    xlabel('Brain')
    ylabel('CI')
    title('组水平 K=14')

    load('DataCI.mat','CI_data11','dataCI1','CI_data22','dataCI2')
    [r(kk),p(kk)]=corr(dataCI1,modelCI1)





    modelCI1_mean(kk)=mean(modelCI1);

    %  [r_210(kk),p_210(kk)]=corr(dataCI1(1:210),modelCI1(1:210))


    for j=1:100
        [r2(j),p2(j)]=corr(CI_model11(:,j),CI_data11(:,j));
        % [r2_210(j),p2_210(j)]=corr(CI_model11(1:210,j),CI_data11(1:210,j));

    end
    % r2=r2(find(r2>0));
    r22(kk)=mean(r2);
    % r22_210(kk)=mean(r2_210);
end
figure
plot(modelCI1,dataCI1,'.k')
%%







figure(4)
plot(MS_MODEL,SE_MODEL,'OB')

figure(3)
subplot(2,1,1)
plot(0:14,r,'-ob')
grid on
xlabel('K')
ylabel('CI fit')
subplot(2,1,2)
bar(0:14,p)
hold on
plot(0:14,ones(1,15).*0.05,'-r')
grid on
xlabel('K')
ylabel('p')

figure(4)
plot(0:14,r,'-ob')
grid on
xlabel('K')
ylabel('CI fit')

figure(5)
plot(0:14,modelCI1_mean,'-OB')
xlabel('K')
ylabel('mean CI')



%%
k0= 4.3365e-04 ./modelCI1_mean(1)
k14= 3.8360e-04./modelCI1_mean(15)

%% steady

clc;clear;
close all;
kk=0;
for K=[14]
    kk=kk+1;
    for j=1:100
        load(['MODEL\246CI\STEADY\',num2str(K),'\CX',num2str(j),'\modeldataCI.mat'],'K','b','kop','MS','SE','CI_model');
        if MS==mean(kop)

            for roi=1:246
                CI_model_roi1=CI_model(roi);
                CI_model_roi1=CI_model_roi1{1,1};
                CI_model1(roi,1)=CI_model_roi1(2,1);
            end
            %             CI_model1=zscore(CI_model1);

            CI_model11(:,j)=CI_model1;
        else
            'error'
        end

    end
    modelCI1=mean(CI_model11,2);

    figure(1)
    plot(CI_model11)
    xlabel('Brain')
    ylabel('CI')
    title(' Homeostatic K=14')

    figure(2)
    subplot(2,1,1)
    plot(CI_model11)
    xlabel('Brain')
    ylabel('CI')
    title('重复100次 Homeostatic K=14')
    subplot(2,1,2)
    plot(modelCI1)
    xlabel('Brain')
    ylabel('CI')
    title('组水平 Homeostatic K=14')

    load('DataCI.mat')
    [r(kk),p(kk)]=corr(dataCI1,modelCI1)
modelCI1_mean(kk)=mean(modelCI1);
    for j=1:100
        [r2(j),p2(j)]=corr(CI_model11(:,j),CI_data11(:,j));
    end
%     r2=r2(find(r2>0));
    r22(kk)=mean(r2);
end
figure
plot(modelCI1,dataCI1,'.k')
%%


figure(3)
subplot(2,1,1)
plot(0:14,r,'-ob')
xlabel('K')
ylabel('CI fit')
title('Homeostatic')
subplot(2,1,2)
bar(0:14,p)
hold on
plot(0:14,ones(1,15).*0.05,'-r')
xlabel('K')
ylabel('p')

figure(5)
plot(0:14,modelCI1_mean,'-OB')
xlabel('K')
ylabel('mean CI')
title('Homeostatic')

figure(6)
plot(0:14,r,'-ob')
xlabel('K')
ylabel('CI fit')
title('Homeostatic')
hold on
plot([0:1 6:14],0.6.*ones(1,11),'*r')
xlim([0 14])
ylim([-0.3 0.7])