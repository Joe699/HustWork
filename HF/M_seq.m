function [mseq,registers] = M_seq(fbconnection, initregister)
%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% fbconnection: ������λ�Ĵ�����ϵ��
% initregister: �Ĵ����ĳ�ʼֵ
% mseq: ���ɵ�m����
%������������primpoly(n,'all')����gfprimfd(n,'all')���Եõ�����nλ�ı�ԭ����ʽ
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
n = length(fbconnection);
N = 2^n-1;
register = initregister; %������λ�Ĵ����ĳ�ʼ״̬
newregister = zeros(1, n);
mseq = zeros(1, N);
registers = register;
for i = 1:N
    mseq(i) = register(n);
    newregister(1)= mod(sum(fbconnection.*register),2);
    newregister(2:n) = register(1:n-1);
    registers = [registers;newregister];
    register = newregister;    
end