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
model_FC0= corr(cc0);%rest FC
model_FC0= abs(model_FC0);
model_FC0cell{t,j}=model_FC0;
fC_matrix=abs(model_FC0-diag(diag(model_FC0)));
%--------------------------------------
[rest_vector2]=uptrielement(fC_matrix);
model_FC=rest_vector2';
% modal  FC    output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[FCFCsimilarity(t,j),ptri1(t,j)]=corr(DATA_FC,model_FC);