function [D]=Iteration(nn,T,dT,rr1,drr1,rr2,drr2,d,dD,DTI_gunter)%Iteration迭代；反复；重复
%nn为改变的脑区，若不改变，写0；T为阈值，rr1为P1，rr2为P2，d为延迟步数；dT，drr1,drr2,dD
%为所改变脑区相应参数的改变量，+为刺激，-为抑制，推荐用编译成C++的同名mex
load DTI_gunter.mat;

%T=0.52
%rr1=0.995;%自激 p1 QE?
%rr2=0.98;%R→Q  P2
%d=55;
%nn=0;


% DTI_gunter=DTI_gunter*0.01;
% pcolor(DTI_gunter)
D=zeros(300001,90);

D(1,:)=uint8(rand(1,90)); %第一行随机0,1

for ll=1:300000  %30000次
    for k=1:90  %90个脑区
        switch D(ll,k)
           case 1   %若此次此脑区状态为1
                if k==nn
                    d=d-dD;
                    D(ll+1,k)=-d;
                    d=d+dD;
                else
                    D(ll+1,k)=-d;
                end
                
            case 0   %若此次此脑区状态为0
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
                
                if Sum>=T       %判断上次所有激活的脑区对此时此脑区的作用总和是否大于阈值
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
                
            case -1  %若此次此脑区状态为-1
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

