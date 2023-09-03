 function [Num_sum,theta,ratioall] = powerbranching_246_2(yy2,dt)
%幂律分布作图和计算分岔参数 
%yy2    向量
%dt     时间窗口
% yy2=S;dt=1;
yy2 = yy2(:)';

if dt ==1
    yy20 = yy2;
else
    
    yy20 = zeros(1,floor(length(yy2)/dt));
    for tt0 = 1:length(yy20)
        ts = (tt0-1).*dt+1;
        yy20(:,tt0) = sum(yy2(:,ts:(ts+dt-1)),2);
    end
end


Num = yy20;
Num = [0 Num 0];

Num1 = Num~=0;
diff01 = diff([0 Num1 0]);%若X为矩阵，% Y = diff（X）= [X(2:n,:) - X(1:n-1,:)]% 求每列前后两项之差
 dnum1 = find(diff01==-1)-find(diff01==1);

dnum1 = [dnum1 0];% 雪崩持续时间

Num0 = Num==0;
diff00 = diff([0 Num0 0]);
 dnum0 = find(diff00==-1)-find(diff00==1);%空窗期

sss = [dnum0;dnum1];
sss = sss(:);% 无雪崩  有雪崩
sss(end) = [];

Num_sum = cellfun(@sum,mat2cell(Num,1,sss));
Num_sum(Num_sum==0) = [];
Numtab = tabulate(Num_sum);%hist 统计 元素  频数  比例

figure

loglog(Numtab(:,1),Numtab(:,2)/sum(Numtab(:,2)),'o','MarkerSize',5)
y0 = Numtab(:,1).^-1.5;
hold on
%     xlim([0 150])
loglog(Numtab(:,1),y0)
hold off
%%%%%%%%%%%%%%%%%%%%%%%%
%幂律分布作图和计算分岔参数
ff = yy20;
%        S = S0;

%Estimating branching parameter

%delete continuous steps with no activity
index0=find(ff==0);
ind_diff=index0(2:length(index0))-index0(1:length(index0)-1);
ko=find(ind_diff==1)+1;
ff(index0(ko))=[];



%branching in each avalanche
aa1 = find(ff(1:end-2)==0);
dff1 = ff(aa1+2)./ff(aa1+1);             %只算 雪崩 头两个时间点
theta = mean(dff1);                  % TWO STEP

aa2 = find(ff(1:end-1)~=0);
dff2 = ff(aa2+1)./ff(aa2);
ratioall = mean(dff2);    %完整雪崩
% % %branching in each avalanche
% % aa1 = find(ff(1:end-2)==0);
% % 
% % erceng=ff(aa1+2);
% % yiceng=ff(aa1+1);
% % dff = ff(aa1+2)./ff(aa1+1);             %只算 雪崩 头两个时间点
% % %         clear d
% % %         aa2 = find(ff(1:end-1)~=0);
% % %         dff = ff(aa2+1)./ff(aa2);
% % %         ratioall(1,k) = mean(dff);    %完整雪崩
% % theta = mean(dff);
end
