function walshseq = walsh_seq(N)
%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% walsh���������
% walshseq: ���ɵ�walsh����
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
M=ceil(log2(N)); 
wn=0;                          
for i=1:M                
   w2n=[wn,wn;wn,~wn];
   wn=w2n;
end
walshseq=wn;