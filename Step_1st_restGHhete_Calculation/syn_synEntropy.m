function [syn,syn_entropy,syn_t] = syn_synEntropy(inputsignal,inputTimeLength,inputCellNumber,numBin)
%this function calculate the synchrony and synchrony entropy of a system
% [syn,syn_entropy,syn_t] = syn_synEntropy(inputsignal,inputTimeLength,inputCellNumber,numBin)
% inputsignal is the system time serise
% inputTimeLength is the number of time points for the system time serise
% inputCellNumber is the number of the system units
% numBin is the hist bin number
% syn is the output return of system's syschronization
% syn_entropy is the output return  
theROITimeCoursesTotal=inputsignal;
    %the hilbert transform in performed to have the analytical signals
    %then have their instaneouse phases
    SIZE=size(theROITimeCoursesTotal);
    Num_vox=SIZE(2);
    if Num_vox~=inputCellNumber
       error('�������󣬳�����ֹ') 
    end
    Time_Point=SIZE(1);
    if Time_Point~=inputTimeLength
       error('�������󣬳�����ֹ') 
    end
    for vox=1:Num_vox
        a(:,vox)=hilbert(theROITimeCoursesTotal(:,vox));%matlab���hilbert������������һ�������źţ�����źŵ�ʵ����ԭ�źţ����鲿����һ��������ϣ�����ر任�ˡ�
        theta(:,vox)=angle(a(:,vox));%angle�������������
    end
    % calculate the Kurumoto order parameteres (r_t) at each time point
    ang=exp(theta*1i);%expָ������.����e��2�η���exp(2)
    for jj=1:1:Time_Point
        syn_t(jj)=abs(sum(ang(jj,1:Num_vox)))./Num_vox;
    end    
    syn=mean(syn_t);%ͬ���̶�
    
    
    syn_t_normalized = (syn_t-min(syn_t))/max(syn_t-min(syn_t)); %%%%%%%%%%%%%%%%%%������(��֮ǰ��ͬ)
    
    bins=linspace(0,1,numBin);
    
    b=hist(syn_t_normalized,bins);
    p=b./Time_Point;
    p(p==0)=[];
    Entropy_rt=0;
    for kk=1:1:length(p)
        Entropy_rt=Entropy_rt-p(kk).*log2(p(kk));
    end
    syn_entropy=Entropy_rt;
end

