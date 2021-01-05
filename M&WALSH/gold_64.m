clear all;
close all;
clc;
fbconnection1 = [1 0 0 0 0 1];%��ԭ����ʽ
fbconnection2 = [1 1 0 0 1 1];%��ԭ����ʽ
initregister = [0 0 0 0 0 1];%�Ĵ�����ʼֵ
[mseq1,registers] = M_seq(fbconnection1,initregister);
[mseq2,registers] = M_seq(fbconnection2,initregister);
goldseq = gold_seq(mseq1,mseq2);
AutocorSidPaPeak = [];
temp = [];
for i = 1:63    
    shift = 32;
    temp(i,1:shift-1) = goldseq(i,1:shift-1);
    temp(i,shift) = 0;
    temp(i,shift+1:64) = goldseq(i,shift:63);
end
goldseq = temp;

% for i = 1:64    
%     shift = i;
%     gold1 = [];
%     gold1(1:shift-1) = goldseq(1,1:shift-1);
%     gold1(shift) = 0;
%     gold1(shift+1:64) = goldseq(1,shift:63);
%     gold2 = [];
%     gold2(1:shift-1) = goldseq(11,1:shift-1);
%     gold2(shift) = 0;
%     gold2(shift+1:64) = goldseq(11,shift:63);
%     goldseq1 = 2*gold1-1;%gold��ת����˫������
%     goldseq2 = 2*gold2-1;%gold��ת����˫������
%     Rk1=ccorr(goldseq1);
%     Rk2=ccorr(goldseq1,goldseq2);
%     AuSidPeak(i) = max(Rk1(65:127));
%     CorPeak(i) = max(Rk2);
% end
% figure(7);
% x = 1:64;
% plot(x,AuSidPeak,'k--*',x,CorPeak,'r--o');    
% ylim([0.1 0.6]);
% title('Gold���е�������԰��ֵ�ͻ���ط�ֵ�油��λ�ñ仯����');
% xlabel('shift');
% ylabel('Peak');
% legend('������԰��ֵ','����ط�ֵ');


for i = 1:length(goldseq)-1
    goldseq_dec1(i,:) = bi2de(goldseq(i,1:32));
    goldseq_dec2(i,:) = bi2de(goldseq(i,33:64));
    goldseq_hex(i,:) = [dec2hex(goldseq_dec2(i,:),8) dec2hex(goldseq_dec1(i,:),8)];
%     goldseq(i,:) = 2*goldseq(i,:)-1;%gold��ת����˫������
%     r(i,:)=ccorr(goldseq(i,:));
%     AutocorSidPaPeak = [AutocorSidPaPeak max(r(i,65:127))];
%     plot(AutocorSidPaPeak,'k-*');
%     axis=-length(goldseq)+1:length(goldseq)-1;%�������ʹ����ط�ֵ��λ��0��
%     figure(i);
% %     y = 0.25*ones(length(axis));
%     plot(axis,r(i,:));
%     % xlim([-1 1]);%���ú����귶Χ
%     ylim([-1.3 1.3]);%���������귶Χ
%     title('α������еĻ��������');
%     xlabel('k');
%     ylabel('R(k)');
%     legend('gold�������������');
end

% goldseq1 = 2*goldseq(1,:)-1;%gold��ת����˫������
% goldseq2 = 2*goldseq(3,:)-1;%gold��ת����˫������
% goldseq3 = 2*goldseq(8,:)-1;%gold��ת����˫������
% goldseq4 = 2*goldseq(21,:)-1;%gold��ת����˫������
% goldseq5 = 2*goldseq(22,:)-1;%gold��ת����˫������
% goldseq6 = 2*goldseq(30,:)-1;%gold��ת����˫������
% goldseq7 = 2*goldseq(32,:)-1;%gold��ת����˫������
% goldseq8 = 2*goldseq(33,:)-1;%gold��ת����˫������
% goldseq9 = 2*goldseq(34,:)-1;%gold��ת����˫������
% goldseq10 = 2*goldseq(38,:)-1;%gold��ת����˫������
% goldseq11 = 2*goldseq(39,:)-1;%gold��ת����˫������
% goldseq12 = 2*goldseq(41,:)-1;%gold��ת����˫������
% goldseq13 = 2*goldseq(51,:)-1;%gold��ת����˫������
% goldseq14 = 2*goldseq(55,:)-1;%gold��ת����˫������
% goldseq15 = 2*goldseq(56,:)-1;%gold��ת����˫������
% goldseq16 = 2*goldseq(61,:)-1;%gold��ת����˫������
% 
% temp1 = goldseq6;
% r1=ccorr(temp1,goldseq1);
% r2=ccorr(temp1,goldseq2);
% r3=ccorr(temp1,goldseq3);
% r4=ccorr(temp1,goldseq4);
% r5=ccorr(temp1,goldseq5);
% r6=ccorr(temp1,goldseq6);
% r7=ccorr(temp1,goldseq7);
% r8=ccorr(temp1,goldseq8);
% r9=ccorr(temp1,goldseq9);
% r10=ccorr(temp1,goldseq10);
% r11=ccorr(temp1,goldseq11);
% r12=ccorr(temp1,goldseq12);
% r13=ccorr(temp1,goldseq13);
% r14=ccorr(temp1,goldseq14);
% r15=ccorr(temp1,goldseq15);
% r16=ccorr(temp1,goldseq16);
% AutocorSidPaPeak = [max(r1(65:127));max(r2(65:127));max(r3(65:127));max(r4(65:127));max(r5(65:127));max(r6(65:127));max(r7(65:127));max(r8(65:127));max(r9(65:127));max(r10(65:127));max(r11(65:127));max(r12(65:127));max(r13(65:127));max(r14(65:127));max(r15(65:127));max(r16(65:127))];
% max(AutocorSidPaPeak)

% axis=-length(goldseq1)+1:length(goldseq1)-1;%�������ʹ����ط�ֵ��λ��0��
% figure();
% subplot(1,2,1);
% plot(axis,r6);
% % xlim([-1 1]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������е����������');
% xlabel('k');
% ylabel('R(k)');
% legend('gold�������������');
% subplot(1,2,2);
% plot(axis,r7);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% legend('gold���л��������');

% axis=-length(goldseq1)+1:length(goldseq1)-1;%�������ʹ����ط�ֵ��λ��0��
% figure(1);
% subplot(2,4,1)
% plot(axis,r1);
% % xlim([-1 1]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('gold���еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% 
% subplot(2,4,2)
% plot(axis,r2);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('gold���еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% 
% subplot(2,4,3)
% plot(axis,r3);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('gold���еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% 
% subplot(2,4,4)
% plot(axis,r4);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('gold���еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% 
% subplot(2,4,5)
% plot(axis,r5);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('gold���еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% 
% subplot(2,4,6)
% plot(axis,r6);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('gold���еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% 
% subplot(2,4,7)
% plot(axis,r7);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('gold���еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% 
% subplot(2,4,8)
% plot(axis,r8);
% % xlim([-20 20]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('gold���еĻ��������');
% xlabel('k');
% ylabel('R(k)');

% figure(2);
% plot(axis,r2);
% % xlim([-1 1]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������еĻ��������');
% xlabel('k');
% ylabel('R(k)');
% legend('gold�������������');