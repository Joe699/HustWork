clear all;
close all;
clc;
% fbconnection1 = [1 0 0 0 0 1];%��ԭ����ʽ
% fbconnection2 = [1 1 0 0 1 1];%��ԭ����ʽ
% initregister = [0 0 0 0 0 1];%�Ĵ�����ʼֵ
fbconnection1 = [1 1 1 0 1];%��ԭ����ʽ
fbconnection2 = [1 0 1 1 1];%��ԭ����ʽ
initregister = [0 0 0 0 1];%�Ĵ�����ʼֵ
[mseq1,registers] = M_seq(fbconnection1,initregister);
[mseq2,registers] = M_seq(fbconnection2,initregister);
% goldseq = gold_seq(mseq1(29:60),mseq2(27:58));
goldseq = gold_seq(mseq1,mseq2);
walshseq = walsh_seq(32);%����32�׵�Walsh�� ����32��

%��m���к�walsh���н����������µ�����
% wlash_m_seq1 = mod(mseq1(29:60)+walshseq(2,:),2);
% wlash_m_seq2 = mod(mseq2(27:58)+walshseq(2,:),2);
wlash_m_seq1 = mod([mseq1 0]+walshseq(2,:),2);
wlash_m_seq2 = mod([mseq2 0]+walshseq(2,:),2);

%��gold���к�walsh���н����������µ�����
% wlash_gold_seq1 = mod(goldseq(13,:)+walshseq(2,:),2);
% wlash_gold_seq2 = mod(goldseq(9,:)+walshseq(3,:),2);
wlash_gold_seq1 = mod([goldseq(1,:) 0]+walshseq(2,:),2);
wlash_gold_seq2 = mod([goldseq(2,:) 0]+walshseq(3,:),2);

% stem(mseq);
% mseq1 = 2*mseq1(29:60) - 1;%m��ת��Ϊ˫������
% mseq2 = 2*mseq2(27:58) - 1;%m��ת��Ϊ˫������
mseq1 = 2*[mseq1 0] - 1;%m��ת��Ϊ˫������
mseq2 = 2*[mseq2 0] - 1;%m��ת��Ϊ˫������

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
    goldseq1 = 2*gold1-1;%gold��ת����˫������
    goldseq2 = 2*gold2-1;%gold��ת����˫������
    Rk1=ccorr(goldseq1);
    Rk2=ccorr(goldseq1,goldseq2);
    AuSidPeak(i) = max(Rk1(33:63));
    CorPeak(i) = max(Rk2);
end

figure(7);
x = 1:32;
plot(x,AuSidPeak,'k--*',x,CorPeak,'r--o');    
ylim([0.1 0.6]);
title('Gold���е�������԰��ֵ�ͻ���ط�ֵ�油��λ�ñ仯����');
xlabel('shift');
ylabel('Peak');
legend('������԰��ֵ','����ط�ֵ');
    

% goldseq1 = 2*goldseq(13,:)-1;%gold��ת����˫������
% goldseq2 = 2*goldseq(9,:)-1;%gold��ת����˫������
walshseq1 = 2*walshseq(2,:)-1;%walsh��ת����˫������
walshseq2 = 2*walshseq(3,:)-1;%walsh��ת����˫������

wlash_m_seq1 = 2*wlash_m_seq1-1;%walsh_m��ת����˫������
wlash_m_seq2 = 2*wlash_m_seq2-1;%walsh_m��ת����˫������

wlash_gold_seq1 = 2*wlash_gold_seq1-1;%walsh_gold��ת����˫������
wlash_gold_seq2 = 2*wlash_gold_seq2-1;%walsh_gold��ת����˫������

%��gold(i)��walsh���н��г˻������µ�����
% for i = 1:length(goldseq(1,:))
%     wlash_gold_seq(i,:) = goldseq1*walshseq1;
% end

%%��������غͻ���ؼ���
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

%���ݴ���
%%
%��ͼ����������
% sequence = {'m����';'gold����';'walsh����';'walsh&m����';'wlash&gold����'};
% label = {'AutocorSidPeak','AutocorSidMean','CroCorPeak','CroCorMean'};%����ط�ֵ ������԰��ֵ ����ط�ֵ ����ؾ�ֵ
% AutocorSidPeak = [max(r1);max(r3);max(r5);max(r7);max(r9)];
% AutocorSidMean = [abs((sum(r1)-max(r1))/length(r1));abs((sum(r3)-max(r3))/length(r3));abs((sum(r5)-max(r5))/length(r5));abs((sum(r7)-max(r7))/length(r7));abs((sum(r9)-max(r9))/length(r9))];
% CroCorPeak = [max(r2);max(r4);max(r6);max(r8);max(r10)];
% CroCorMean = [abs(mean(r2));abs(mean(r4));abs(mean(r6));abs(mean(r8));abs(mean(r10))];
% T = table(AutocorSidPeak,AutocorSidMean,CroCorPeak,CroCorMean,'VariableNames',label,'RowNames',sequence);
% T
%% ������� 
AutocorSidPeak = [max(r1);max(r3);max(r5);max(r7);max(r9)];
AutocorSidPaPeak = [max(r1(33:63));max(r3(33:63));max(r5(33:63));max(r7(33:63));max(r9(33:63))];
% AutocorSidPaPeak = [max(r1(33:61));max(r3(33:61));max(r5(33:61));max(r7(33:61));max(r9(33:61))];
CroCorPeak = [max(r2);max(r4);max(r6);max(r8);max(r10)];
data=[AutocorSidPeak,AutocorSidPaPeak,CroCorPeak];
%���ɱ���������ƣ�m��n��
column_name={'����ط�ֵ','������԰��ֵ','����ط�ֵ'};
row_name={'m����';'gold����';'walsh����';'walsh&m����';'wlash&gold����'};
% �����ͼ
gcf = figure(6);
uitable(gcf,'Data',data,'Position',[20 20 497 400],'Columnname',column_name,'Rowname',row_name);
%%
% disp('������������԰��ֵ�ֲ�');
% tabulate([(sum(r1)-max(r1))/length(r1) (sum(r3)-max(r3))/length(r3) (sum(r5)-max(r5))/length(r5) (sum(r7)-max(r7))/length(r7) (sum(r9)-max(r9))/length(r9)]);
% 
% disp('�����л���ط�ֵ�ֲ�');
% tabulate([max(r2) max(r4) max(r6) max(r8) max(r10)]);
% 
% disp('�����л���ؾ�ֵ�ֲ�');
% tabulate([mean(r2) mean(r4) mean(r6) mean(r8) mean(r10)]);
%%
% axis=-length(mseq1)+1:length(mseq1)-1;%�������ʹ����ط�ֵ��λ��0��
% figure(1);
% subplot(1,2,1);
% plot(axis,r1);
% % xlim([-1 1]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������е����������');
% xlabel('k');
% ylabel('R(k)');
% legend('m�������������');
% 
% subplot(1,2,2);
% plot(axis,r2);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% legend('m���л��������');
% 
% figure(2);
% subplot(1,2,1);
% plot(axis,r3);
% % xlim([-1 1]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������е����������');
% xlabel('k');
% ylabel('R(k)');
% legend('gold�������������');
% 
% subplot(1,2,2);
% plot(axis,r4);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% legend('gold���л��������');
% 
% axis=-length(walshseq1)+1:length(walshseq1)-1;%�������ʹ����ط�ֵ��λ��0��
% figure(3);
% subplot(1,2,1);
% plot(axis,r5);
% xlim([-10 10]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������е����������');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh�������������');
% subplot(1,2,2);
% plot(axis,r6);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh���л��������');
% 
% figure(4);
% subplot(1,2,1);
% plot(axis,r7);
% %xlim([-10 10]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������е����������');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh&m�������������');
% subplot(1,2,2);
% plot(axis,r8);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh&m���л��������');
% 
% figure(5);
% subplot(1,2,1);
% plot(axis,r9);
% %xlim([-10 10]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������е����������');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh&gold�������������'); 
% subplot(1,2,2);
% plot(axis,r10);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% legend('walsh&gold���л��������');
