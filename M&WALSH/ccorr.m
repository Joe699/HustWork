function r=ccorr(seq1,seq2)
%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% mseq1,mseq2: 进行相关计算的两个序列
% r: 相关计算的结果
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
if nargin==1
    seq2=seq1;
end
N=length(seq1);
for k=-N+1:-1
    seq2_shift=[seq2(k+N+1:N) seq2(1:k+N)];
    r(N+k)=seq1*seq2_shift'/length(seq1);
end
for k=0:N-1
    seq2_shift=[seq2(k+1:N) seq2(1:k)];
    r(N+k)=seq1*seq2_shift'/length(seq1);
end