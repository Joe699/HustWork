function[goldseq]=gold_seq(mseq1,mseq2)
%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% mseq1,mseq2: ��Ϊ��ѡ�Ե�����M����
% goldseq: ���ɵ�gold����
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
N=length(mseq1);
for shift_amount=0:N-1
    %�����е�һ��m���е�ѭ����λ�õ��µ�gold����
    shift_mseq2=[mseq2(shift_amount+1:N) mseq2(1:shift_amount)];
    goldseq(shift_amount+1,:)=mod(mseq1+shift_mseq2,2);
end