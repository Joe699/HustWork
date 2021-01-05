function [mseq,registers] = M_seq(fbconnection, initregister)
%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% fbconnection: 线性移位寄存器的系数
% initregister: 寄存器的初始值
% mseq: 生成的m序列
%命令行中输入primpoly(n,'all')或者gfprimfd(n,'all')可以得到所有n位的本原多项式
%本原多项式 从低位到高位 与gfprimfd(n,'all')结果除去第一个元素的其他元素保持一致
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
n = length(fbconnection);
N = 2^n-1;
register = initregister; %定义移位寄存器的初始状态
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


%%
% function mseq = M_seq(polynomial)
%     n = length(polynomial);
%     N = 2^n - 1;
%     register=[zeros(1,n-1) 1];
%     mseq(1)=register(n);
%     for i=2:N
%         newregister(1)=mod(sum(polynomial.*register),2);
%         for j=2:n
%             newregister(j)=register(j-1);
%         end  
%         register=newregister;
%         mseq(i)=register(n);
%     end
 %%
    
 

