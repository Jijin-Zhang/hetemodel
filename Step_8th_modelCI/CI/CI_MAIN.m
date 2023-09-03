%model
D=Iteration_htc246hem3_vec(Tm,0.995,0.98,55,DTI_gunter,ts);
%simulation data
D=D(1000:end,:);
D(D<0) = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cc0=zeros(length(D)-1+1001,246);
for kk=1:246
    cc0(:,kk)=conv(D(:,kk),HRFunction_246());  %simulate BOLD
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signals=cc0;
%calculate the kuramoto parameter
kop = xlz_kop(signals');
bins_num = 30;
[MS, SS, CS, SE, sample_failed] =  xlz_kop2sta(kop, bins_num);
%calculate the A OF BOLD
SIGNALS=signals';
[ele_num, time_num] = size(SIGNALS);
% obtain the instaneouse phase
for NN = 1 : ele_num
    a_s(NN,:) = hilbert(SIGNALS(NN,:)); %analytical signals
    theta(NN,:) = angle(a_s(NN,:));% instaneouse phases
    amplitude(NN,:) = abs(a_s(NN,:));
end
%calculate the CI
for seed=1:246
    X=amplitude(seed,1:end);
    XX=[X;kop];
    N=size(XX,1);
    if N~=2
        'error'
    else
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        NLags=10*ones(N,N);
        [CI_model{seed}] = pair_granger_norm(XX,NLags);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
toc