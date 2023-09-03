function  [rest_vector1]=uptrielement(sFC)
%∑Ω’Û …œ»˝Ω«
[H,L]=size(sFC);
rest_vector1=[];
for hang1=1:H;
    for lie1=hang1+1:L;
        A=sFC(hang1,lie1);
        rest_vector1=[rest_vector1,A];
    end
end
end

% [HH,LL]=size(fC_matrix);
% rest_vector2=[];
% for hang2=1:HH;
%     for lie2=hang2+1:LL;
%         AA=fC_matrix(hang2,lie2);
%         rest_vector2=[rest_vector2,AA];
%     end
% end