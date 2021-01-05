function[goldseq]=gold_seq(mseq1,mseq2)
%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% mseq1,mseq2: 互为优选对的两个M序列
% goldseq: 生成的gold序列
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
N=length(mseq1);
for shift_amount=0:N-1
    %将其中的一个m序列的循环移位得到新的gold序列
    shift_mseq2=[mseq2(shift_amount+1:N) mseq2(1:shift_amount)];
    goldseq(shift_amount+1,:)=mod(mseq1+shift_mseq2,2);
end