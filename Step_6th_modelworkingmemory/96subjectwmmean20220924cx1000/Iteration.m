function [D]=Iteration(nn,T,dT,rr1,drr1,rr2,drr2,d,dD,DTI_gunter)%Iteration�������������ظ�
%nnΪ�ı�������������ı䣬д0��TΪ��ֵ��rr1ΪP1��rr2ΪP2��dΪ�ӳٲ�����dT��drr1,drr2,dD
%Ϊ���ı�������Ӧ�����ĸı�����+Ϊ�̼���-Ϊ���ƣ��Ƽ��ñ����C++��ͬ��mex
load DTI_gunter.mat;

%T=0.52
%rr1=0.995;%�Լ� p1 QE?
%rr2=0.98;%R��Q  P2
%d=55;
%nn=0;


% DTI_gunter=DTI_gunter*0.01;
% pcolor(DTI_gunter)
D=zeros(300001,90);

D(1,:)=uint8(rand(1,90)); %��һ�����0,1

for ll=1:300000  %30000��
    for k=1:90  %90������
        switch D(ll,k)
           case 1   %���˴δ�����״̬Ϊ1
                if k==nn
                    d=d-dD;
                    D(ll+1,k)=-d;
                    d=d+dD;
                else
                    D(ll+1,k)=-d;
                end
                
            case 0   %���˴δ�����״̬Ϊ0
               r_1=rand(1);
                Sum=0;
                for j=1:90
                    if D(ll,j)>=0
                        Sum=Sum+D(ll,j)*DTI_gunter(k,j);    %
                    else
                        continue
                    end
                end
                
%                 if k==nn
%                     rr1=rr1-drr1;
%                     T=T-dT;
%                 end
                
                if Sum>=T       %�ж��ϴ����м���������Դ�ʱ�������������ܺ��Ƿ������ֵ
                    D(ll+1,k)=1;
                elseif r_1>=rr1
                    D(ll+1,k)=1;
                else D(ll+1,k)=0;
                end
                
%                 if k==nn
%                     rr1=rr1+drr1;
%                     T=T+dT;
%                     
%                 end
                
            case -1  %���˴δ�����״̬Ϊ-1
                r_2=rand(1);
                
                if k==nn
                    rr2=rr2-drr2;
                end
                
                if r_2>=rr2
                    D(ll+1,k)=0;
                else
                    D(ll+1,k)=-1;
                end
                
                if k==nn
                    rr2=rr2+drr2;
                end
                
            otherwise
                D(ll+1,k)=D(ll,k)+1;
        end
    end
end

end

