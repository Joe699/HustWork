clear all;
close all;
clc;
todh = 0;
M = 10;  % TODH位数
C = 9;  % 生成的Freq位数
N = 2^M;
fbconnection = [0 0 1 0 0 0 0 0 0 1];%本原多项式 从低位到高位 与gfprimfd(n,'all')顺序一致
initregister = [0 0 0 0 0 0 0 0 0 1];%寄存器初始值
[mseq1,registers] = M_seq(fbconnection, initregister);
% mseq1 = 2*mseq1 - 1;%m码转换为双极性码
% r1=ccorr(mseq1);
% axis=-length(mseq1)+1:length(mseq1)-1;%定义横轴使自相关峰值移位到0点
% figure(1);
% plot(axis,r1);
% resgiter = randi([0 1],C,M);
for i = 1:N
    temp = de2bi(int32(todh),M,'left-msb');
    n = length(temp);
    for j = 1:length(temp)
        if n == 1
            gray(n) = mod(temp(n)+0,2);
        else
            gray(n) = mod(temp(n)+temp(n-1),2);
        end
        n = n - 1;
    end    
    
    mseqs = [];
    for k = 1:C
        %temp2(k) = mod(sum(mod(double(temp)+registers(k,:),2)),2);
        temp2(k) = mod(sum(double(temp).*registers(k,:)),2);
        %temp2(k) = mod(sum(mod(double(temp)+resgiter(k,:),2)),2);
        %temp2(k) = mod(sum(double(gray).*resgiter(k,:)),2);
        
        temp1 = registers(1,:);
        registers(1:length(registers)-1,:) = registers(2:length(registers),:);
        registers(length(registers),:) = temp1;
    end
    
    freq(i) = bi2de(temp2,'left-msb');
    
    if i == 1
        freq_diff(i) =  abs(freq(i) - 0);
    else
        freq_diff(i) =  abs(freq(i) - freq(i-1));
    end
    
    if todh == N-1
        todh = 0;
    else
        todh = todh + 1;
    end
end

temp3 = [];
L = 100;
for shift = 1:L
    temp3(1:shift) = freq(length(freq)-shift+1:length(freq));
    temp3(shift+1:length(freq)) = freq(1:length(freq)-shift);
    freq_diff_shift(shift,:) = abs(temp3 - freq);
    freq_diff_shift_min(shift) = min(freq_diff_shift(shift,:));
    freq_diff_shift_mean(shift) = mean(freq_diff_shift(shift,:));
%     min(freq_diff_shift)
end
x = 1:L;
figure();
plot(x,freq_diff_shift_min,'k-o')
title('不同间隔下的最小频率差');
xlabel('间隔');
ylabel('频率差最小值');
figure();
plot(x,freq_diff_shift_mean,'k-o')
title('不同间隔下的频率差均值');
xlabel('间隔');
ylabel('频率差均值');
figure();
y = 1:length(freq_diff_shift(1,:));
plot(y,freq_diff_shift(1,:),'o')
title('不同间隔下的频率差分布');
xlabel('k');
ylabel('频率差');
% disp('频率差分布');
% tabulate(freq_diff_shift);

disp('频率分布');
tabulate(freq);
% disp('频率差分布');
% tabulate(freq_diff);% plot(freq,'r*');