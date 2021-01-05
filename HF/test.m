clear all;
close all;
clc;
todh = 0;
M = 20;  % TODH位数
C = 9;  % 生成的Freq位数
N = 2^M;
% resgiter = randi([0 1],C,M);
% resgiter = [1	1	1	0	0	0	1	1	0	0;
%             1	0	0	1	1	1	0	0	0	1;
%             1	0	1	1	0	0	0	0	1	0;
%             0	1	1	0	0	1	1	1	1	0;
%             1	1	1	1	1	0	0	1	0	1;
%             1	0	0	0	1	0	1	1	1	0;
%             0	0	1	1	0	1	0	0	0	0;
%             0	1	1	0	1	0	0	0	1	1;
%             0	0	1	0	1	1	0	1	0	0];

% resgiter = [0	0	0	1	0	0	1	1	1	1	0	0	1	0	1	1;
%             0	0	1	1	0	0	0	0	1	1	0	0	0	1	0	0;
%             1	1	0	1	0	1	1	0	1	0	1	1	0	1	1	1;
%             1	1	1	1	1	0	1	1	0	1	1	1	1	1	1	1;
%             1	1	0	1	0	0	0	1	1	0	0	0	0	0	0	1;
%             1	1	0	0	0	0	1	1	1	0	1	0	0	1	0	1;
%             0	1	0	0	0	1	1	0	0	0	0	0	0	1	0	0;
%             1	0	0	0	0	0	1	1	0	0	1	1	1	1	0	1;
%             0	0	1	0	1	0	1	0	0	1	1	1	0	0	0	1];
        
resgiter = [1	1	0	0	1	1	0	1	0	1	0	1	1	0	0	0	1	0	1	1;
            0	1	1	0	1	1	1	1	0	0	0	0	1	0	1	1	0	1	0	0;
            1	1	0	0	0	0	0	0	1	1	0	0	1	1	0	1	1	1	1	0;
            0	1	0	1	1	1	1	1	0	1	1	0	0	0	1	0	1	1	0	0;
            1	0	0	1	0	0	1	1	1	0	0	1	0	0	0	0	0	1	1	0;
            1	0	0	0	0	0	1	1	0	0	0	1	0	1	1	1	1	0	1	0;
            1	0	0	1	1	0	1	1	1	1	0	0	0	1	1	1	1	1	1	0;
            0	0	1	0	1	1	0	1	0	0	1	1	1	0	0	0	1	1	1	0;
            0	0	0	1	0	0	0	1	0	0	0	1	0	0	1	0	0	1	1	1];

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
    
    for k = 1:C
        temp2(k) = mod(sum(double(gray).*resgiter(k,:)),2);
    end
    
    freq(i) = bi2de(temp2,'left-msb');
    
    if todh == N-1
        todh = 0;
    else
        todh = todh + 1;
    end
end

fp = fopen('E:\yjw_maltab_project\HF\freq.bin','wb');
fwrite(fp,freq,'int16'); 
fclose(fp);
%%
% temp3 = [];
% L = 4096;
% for shift = 1:L
%     temp3(1:shift) = freq(length(freq)-shift+1:length(freq));
%     temp3(shift+1:length(freq)) = freq(1:length(freq)-shift);
%     freq_diff_shift_min(shift) = min(abs(temp3 - freq));
%     clear temp3
%     temp3 =[];
% end
% disp('开始检索');
% dis = [];
% for shift = 1:L/8
%     if (freq_diff_shift_min(shift)>4)&&(freq_diff_shift_min(2*shift)>4)&&(freq_diff_shift_min(3*shift)>4)&&(freq_diff_shift_min(4*shift)>4)&&(freq_diff_shift_min(5*shift)>4)&&(freq_diff_shift_min(6*shift)>4)&&(freq_diff_shift_min(7*shift)>4)
%         dis = [dis shift];
%         break
%     end
% end

% x = 1:L;
% figure();
% plot(x,freq_diff_shift_min,'k-o')
% title('不同移动位置下的最小频率差');
% xlabel('移动位置/shift');
% ylabel('频率差最小值/min');
% figure();
% plot(x,freq_diff_shift_mean,'k-o')
% title('不同移动位置下的频率差均值');
% xlabel('移动位置/shift');
% ylabel('频率差均值/mean');
% figure();
% y = 1:length(freq_diff_shift(1,:));
% plot(y,freq_diff_shift(1,:),'o')
% title('不同间隔下的频率差分布');
% xlabel('k');
% ylabel('频率差');
% disp('频率差分布');
% tabulate(freq_diff_shift);

% disp('频率分布');
% tabulate(freq);
% disp('频率差分布');
% tabulate(freq_diff);
%%
figure();
a=hist(freq,512);
plot(a);
title('不同频点出现的个数');
xlabel('频点');
ylabel('频点对应的个数');