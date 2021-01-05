%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% 探究walsh码和gold的组合码之间的关系
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
clear all;
close all;
clc;
N = 22;
fbconnection1 = [1 1 1 0 1];%本原多项式
fbconnection2 = [1 0 1 1 1];%本原多项式
initregister = [0 0 0 0 1];%寄存器初始值
[mseq1,registers] = M_seq(fbconnection1,initregister);
[mseq2,registers] = M_seq(fbconnection2,initregister);
goldseq = gold_seq(mseq1,mseq2);
walshseq = walsh_seq(32);%产生32阶的Walsh码 共有32个

for i=1:N
    wlash_gold_seq(i,:) = mod([goldseq(i,:) 0]+walshseq(i+1,:),2);
    temp = 0;
    for j=1:length(wlash_gold_seq(i,:))
        temp = temp + wlash_gold_seq(i,j)*2^(j-1);
    end
    wlash_gold_seq_hex(i,:) = dec2hex(temp,8);
end
%wlash_gold_seq_hex
for i=1:N
    wlash_gold_seq(i,:) = 2*wlash_gold_seq(i,:)-1;%walsh_gold码转换成双极性码;
    r(i,:)=ccorr(wlash_gold_seq(1,:),wlash_gold_seq(i,:));
    CroCorPeak(i) = max(abs(r(i,:)));
    CroCorMean(i) = mean(abs(r(i,:)));
end

axis=-length(walshseq)+1:length(walshseq)-1;%定义横轴使自相关峰值移位到0点
figure(1);
subplot(1,2,1);
plot(axis,r(1,:));
xlim([-10 10]);%设置横坐标范围
ylim([-1.3 1.3]);%设置纵坐标范围
title('伪随机序列的自相关特性');
xlabel('k');
ylabel('R(k)');
legend('wlash&gold序列自相关特性');
subplot(1,2,2);
plot(axis,r(2,:));
% xlim([-20 20]);%设置横坐标范围
ylim([-1.3 1.3]);%设置纵坐标范围
title('伪随机序列的互相关特性');
xlabel('k');
ylabel('R(k)');
legend('wlash&gold序列互相关特性');

figure(2);
plot(CroCorPeak);
title('22种walsh&gold码互相关峰值曲线');
xlabel('k');
ylabel('互相关峰值');

figure(3);
plot(CroCorMean);
title('22种walsh&gold码互相关均值曲线');
xlabel('k');
ylabel('互相关均值');