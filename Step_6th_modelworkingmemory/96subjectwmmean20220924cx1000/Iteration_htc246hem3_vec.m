function [D]=Iteration_htc246hem3_vec(Tm,rr1,rr2,d,DTI_gunter,ts)%Iteration迭代；反复；重复
%nn为改变的脑区，若不改变，�?0；T为阈值，rr1为P1，rr2为P2，d为延迟步数；dT，drr1,drr2,dD
%为所改变脑区相应参数的改变量�?+为刺�?�?-为抑制，推荐用编译成C++的同名mex


% ts=60000%htc  加入稳�?�可塑原�?


D=zeros(ts+1,246);

% D(1,:)=uint8(rand(1,246)); %第一行随�?0,1
D(1,:)=uint8(rand(1,246)   ); %第一行随�?0,1    >0.82  

for ll=1:ts  %60000�?
    % case 1 (E->R)
    Ei = D(ll, :)' > 0;
    D(ll + 1, Ei) = -d;
    % case 0 (Q->E)
    Qi = D(ll, :)' == 0;
    Qc = sum(Qi);
    if Qc > 0
        r_1 = rand(246, 1);
        input = sum(DTI_gunter(:, Ei), 2);
        Q2E = Qi & (input >= Tm(:) | r_1 >= rr1);
        D(ll + 1, Q2E) = 1;
    end
    % case -1 (R->Q)
    Ri = D(ll, :)' == -1;
    D(ll + 1, Ri) = -1;
    Rc = sum(Ri);
    if Rc > 0
        r_2 = rand(246, 1);
        R2Q = Ri & r_2 >= rr2;
        D(ll + 1, R2Q) = 0;
    end
    % case other
    Ri = D(ll, :)' < -1;
    D(ll + 1, Ri) = D(ll, Ri) + 1;
end

end

