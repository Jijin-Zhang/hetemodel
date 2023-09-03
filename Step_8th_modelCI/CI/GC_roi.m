function CI = GC_roi(BOLD_signal)

Kop=xlz_kop(BOLD_signal');
SIGNALS = BOLD_signal';

nNode = size(SIGNALS,1);
for iNode = 1 : nNode
    a_s(iNode,:) = hilbert(SIGNALS(iNode,:)); %analytical signals
                                      
    Amplitude(iNode,:) = abs(a_s(iNode,:));
    XX = [Amplitude(iNode,:);Kop];
    NLags=10*ones(size(XX,1));
    
    [GCsim] = pair_granger_norm(XX,NLags);
    CI{iNode}=GCsim;
end
 

for roi=1:246
            CI_data_roi1=CI(roi);
            CI_data_roi1=CI_data_roi1{1,1};
            CI_data1(roi,1)=CI_data_roi1(2,1);
end
       
CI = CI_data1;
