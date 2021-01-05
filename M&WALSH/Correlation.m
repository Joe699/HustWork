clear all;
close all;
clc;
% fbconnection1 = [1 0 0 0 0 1];%本原多项式
% fbconnection2 = [1 1 0 0 1 1];%本原多项式
% initregister = [0 0 0 0 0 1];%寄存器初始值
fbconnection1 = [1 1 1 0 1];%本原多项式
fbconnection2 = [1 0 1 1 1];%本原多项式
initregister = [0 0 0 0 1];%寄存器初始值
[mseq1,registers] = M_seq(fbconnection1,initregister);
[mseq2,registers] = M_seq(fbconnection2,initregister);
% goldseq = gold_seq(mseq1(29:60),mseq2(27:58));
goldseq = gold_seq(mseq1,mseq2);
walshseq = walsh_seq(32);%产生32阶的Walsh码 共有32个

%将m序列和walsh序列进行异或产生新的序列
% wlash_m_seq1 = mod(mseq1(29:60)+walshseq(2,:),2);
% wlash_m_seq2 = mod(mseq2(27:58)+walshseq(2,:),2);
wlash_m_seq1 = mod([mseq1 0]+walshseq(2,:),2);
wlash_m_seq2 = mod([mseq2 0]+walshseq(2,:),2);

%将gold序列和walsh序列进行异或产生新的序列
% wlash_gold_seq1 = mod(goldseq(13,:)+walshseq(2,:),2);
% wlash_gold_seq2 = mod(goldseq(9,:)+walshseq(3,:),2);
wlash_gold_seq1 = mod([goldseq(1,:) 0]+walshseq(2,:),2);
wlash_gold_seq2 = mod([goldseq(2,:) 0]+walshseq(3,:),2);

% stem(mseq);
% mseq1 = 2*mseq1(29:60) - 1;%m码转换为双极性码
% mseq2 = 2*mseq2(27:58) - 1;%m码转换为双极性码
mseq1 = 2*[mseq1 0] - 1;%m码转换为双极性码
mseq2 = 2*[mseq2 0] - 1;%m码转换为双极性码

for i = 1:32    
    shift = i;
    gold1 = [];
    gold1(1:shift-1) = goldseq(1,1:shift-1);
    gold1(shift) = 0;
    gold1(shift+1:32) = goldseq(1,shift:31);
    gold2 = [];
    gold2(1:shift-1) = goldseq(11,1:shift-1);
    gold2(shift) = 0;
    gold2(shift+1:32) = goldseq(11,shift:31);
    goldseq1 = 2*gold1-1;%gold码转换成双极性码
    goldseq2 = 2*gold2-1;%gold码转换成双极性码
    Rk1=ccorr(goldseq1);
    Rk2=ccorr(goldseq1,goldseq2);
    AuSidPeak(i) = max(Rk1(33:63));
    CorPeak(i) = max(Rk2);
end

figure(7);
x = 1:32;
plot(x,AuSidPeak,'k--*',x,CorPeak,'r--o');    
ylim([0.1 0.6]);
title('Gold序列的自相关旁瓣峰值和互相关峰值随补零位置变化曲线');
xlabel('shift');
ylabel('Peak');
legend('自相关旁瓣峰值','互相关峰值');
    

% goldseq1 = 2*goldseq(13,:)-1;%gold码转换成双极性码
% goldseq2 = 2*goldseq(9,:)-1;%gold码转换成双极性码
walshseq1 = 2*walshseq(2,:)-1;%walsh码转换成双极性码
walshseq2 = 2*walshseq(3,:)-1;%walsh码转换成双极性码

wlash_m_seq1 = 2*wlash_m_seq1-1;%walsh_m码转换成双极性码
wlash_m_seq2 = 2*wlash_m_seq2-1;%walsh_m码转换成双极性码

wlash_gold_seq1 = 2*wlash_gold_seq1-1;%walsh_gold码转换成双极性码
wlash_gold_seq2 = 2*wlash_gold_seq2-1;%walsh_gold码转换成双极性码

%将gold(i)和walsh序列进行乘积产生新的序列
% for i = 1:length(goldseq(1,:))
%     wlash_gold_seq(i,:) = goldseq1*walshseq1;
% end

%%进行自相关和互相关计算
r1=ccorr(mseq1);
r2=ccorr(mseq1,mseq2);
r3=ccorr(goldseq1);
r4=ccorr(goldseq1,goldseq2);
r5=ccorr(walshseq1);
r6=ccorr(walshseq1,walshseq2);
r7=ccorr(wlash_m_seq1);
r8=ccorr(wlash_m_seq1,wlash_m_seq2);
r9=ccorr(wlash_gold_seq1);
r10=ccorr(wlash_gold_seq1,wlash_gold_seq2);

%数据处理
%%
%绘图及分析数据
% sequence = {'m序列';'gold序列';'walsh序列';'walsh&m序列';'wlash&gold序列'};
% label = {'AutocorSidPeak','AutocorSidMean','CroCorPeak','CroCorMean'};%自相关峰值 自相关旁瓣均值 互相关峰值 互相关均值
% AutocorSidPeak = [max(r1);max(r3);max(r5);max(r7);max(r9)];
% AutocorSidMean = [abs((sum(r1)-max(r1))/length(r1));abs((sum(r3)-max(r3))/length(r3));abs((sum(r5)-max(r5))/length(r5));abs((sum(r7)-max(r7))/length(r7));abs((sum(r9)-max(r9))/length(r9))];
% CroCorPeak = [max(r2);max(r4);max(r6);max(r8);max(r10)];
% CroCorMean = [abs(mean(r2));abs(mean(r4));abs(mean(r6));abs(mean(r8));abs(mean(r10))];
% T = table(AutocorSidPeak,AutocorSidMean,CroCorPeak,CroCorMean,'VariableNames',label,'RowNames',sequence);
% T
%% 表格数据 
AutocorSidPeak = [max(r1);max(r3);max(r5);max(r7);max(r9)];
AutocorSidPaPeak = [max(r1(33:63));max(r3(33:63));max(r5(33:63));max(r7(33:63));max(r9(33:63))];
% AutocorSidPaPeak = [max(r1(33:61));max(r3(33:61));max(r5(33:61));max(r7(33:61));max(r9(33:61))];
CroCorPeak = [max(r2);max(r4);max(r6);max(r8);max(r10)];
data=[AutocorSidPeak,AutocorSidPaPeak,CroCorPeak];
%生成表格行列名称，m行n列
column_name={'自相关峰值','自相关旁瓣峰值','互相关峰值'};
row_name={'m序列';'gold序列';'walsh序列';'walsh&m序列';'wlash&gold序列'};
% 表格作图
gcf = figure(6);
uitable(gcf,'Data',data,'Position',[20 20 497 400],'Columnname',column_name,'Rowname',row_name);
%%
% disp('各序列自相关旁瓣均值分布');
% tabulate([(sum(r1)-max(r1))/length(r1) (sum(r3)-max(r3))/length(r3) (sum(r5)-max(r5))/length(r5) (sum(r7)-max(r7))/length(r7) (sum(r9)-max(r9))/length(r9)]);
% 
% disp('各序列互相关峰值分布');
% tabulate([max(r2) max(r4) max(r6) max(r8) max(r10)]);
% 
% disp('各序列互相关均值分布');
% tabulate([mean(r2) mean(r4) mean(r6) mean(r8) mean(r10)]);
%%
% axis=-length(mseq1)+1:length(mseq1)-1;%定义横轴使自相关峰值移位到0点
% figure(1);
% subplot(1,2,1);
% plot(axis,r1);
% % xlim([-1 1]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的自相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('m序列自相关特性');
% 
% subplot(1,2,2);
% plot(axis,r2);
% % xlim([-20 20]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的互相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('m序列互相关特性');
% 
% figure(2);
% subplot(1,2,1);
% plot(axis,r3);
% % xlim([-1 1]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的自相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('gold序列自相关特性');
% 
% subplot(1,2,2);
% plot(axis,r4);
% % xlim([-20 20]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的互相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('gold序列互相关特性');
% 
% axis=-length(walshseq1)+1:length(walshseq1)-1;%定义横轴使自相关峰值移位到0点
% figure(3);
% subplot(1,2,1);
% plot(axis,r5);
% xlim([-10 10]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的自相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh序列自相关特性');
% subplot(1,2,2);
% plot(axis,r6);
% % xlim([-20 20]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的互相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh序列互相关特性');
% 
% figure(4);
% subplot(1,2,1);
% plot(axis,r7);
% %xlim([-10 10]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的自相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh&m序列自相关特性');
% subplot(1,2,2);
% plot(axis,r8);
% % xlim([-20 20]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的互相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh&m序列互相关特性');
% 
% figure(5);
% subplot(1,2,1);
% plot(axis,r9);
% %xlim([-10 10]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的自相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh&gold序列自相关特性'); 
% subplot(1,2,2);
% plot(axis,r10);
% % xlim([-20 20]);%设置横坐标范围
% ylim([-1.3 1.3]);%设置纵坐标范围
% title('伪随机序列的互相关特性');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh&gold序列互相关特性');
