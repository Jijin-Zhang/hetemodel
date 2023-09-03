%中间过程检查
function [Num_sum,ff,theta,ratioall] = rasteravalanchedynamic2(GH,TIME,TIME_BIN,A)
%1 raster plot
%  TIME = 60000;
% TIME =300000;
GH_1 = GH';
GH_RASTER = GH_1(:,TIME-1000:end);
KK = 0;
for S1 = 1:length(GH_RASTER(:,1))
    for S2 = 1:length(GH_RASTER(1,:))
        if GH_RASTER(S1,S2) == 1
            KK = KK+1; 
            GH_RS(KK,1) = S2;
            GH_RS(KK,2) = S1;
        else 
            continue
        end
    end
end
% figure 
% subplot(2,1,1)
% plot(GH_RS(:,1),GH_RS(:,2),'*');
% title('1000 step raster');

%2 %% avalanche dynamic
ACTIVE = sum(GH,2);
ACTIVE = ACTIVE(:)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  TIME_BIN = 1;
%TIME_BIN =2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TIME BIN 
if TIME_BIN ==1
    
    ACTIVE_bin = ACTIVE;
else
    
    ACTIVE_bin = zeros(1,floor(length(ACTIVE)/TIME_BIN));
    for tt0 = 1:length(ACTIVE_bin)
        ts = (tt0-1).*TIME_BIN+1;
        ACTIVE_bin(:,tt0) = sum(ACTIVE(:,ts:(ts+TIME_BIN-1)),2);
    end
    
end
%
Num = ACTIVE_bin;
Num = [0 Num 0];
% 
Num1 = Num~=0; % 0 = Q; 1 = E;
diff01 = diff([0 Num1 0]); % 1: from Q to E; -1 means from E to Q
dnum1 = find(diff01==-1)-find(diff01==1); % avalanche duration
dnum1 = [dnum1 0];
%
Num0 = Num==0;
diff00 = diff([0 Num0 0]);
dnum0 = find(diff00==-1)-find(diff00==1); % rest time

sss = [dnum0;dnum1];
sss = sss(:);
sss(end) = [];
Num_sum = cellfun(@sum,mat2cell(Num,1,sss));
Num_sum(Num_sum==0) = [];

Numtab = tabulate(Num_sum); % like the hist

subplot(2,1,2)
loglog(Numtab(:,1),Numtab(:,2)/sum(Numtab(:,2)),'o','MarkerSize',5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x=Num_sum;
% varargin=1;
% [tau, xmin, xmax, L] = plmle(x, varargin);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%y0 = Numtab(:,1).^-1.5;
 y0 = Numtab(:,1).^(-A);
hold on
%     xlim([0 150])
loglog(Numtab(:,1),y0)
hold off

% %%%%%%%%%%%%%%%%%%%%%%%%
% %计算分岔参数
ff = ACTIVE_bin;
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
end