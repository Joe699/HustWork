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
AutocorSidPaPeak = [];
temp = [];
for i = 1:31    
    shift = 3;
    temp(i,1:shift-1) = goldseq(i,1:shift-1);
    temp(i,shift) = 0;
    temp(i,shift+1:32) = goldseq(i,shift:31);
end
goldseq = temp;

% for i = 1:length(goldseq)-1
%     temp = 0;
%     for j=1:length(goldseq(i,:))
%         temp = temp + goldseq(i,j)*2^(j-1);
%     end
%     goldseq_hex(i,:) = dec2hex(temp,8);
%     goldseq(i,:) = 2*goldseq(i,:)-1;%gold��ת����˫������
%     r(i,:)=ccorr(goldseq(i,:));
%     AutocorSidPaPeak = [AutocorSidPaPeak max(r(i,33:63))];
%     axis=-length(goldseq)+1:length(goldseq)-1;%�������ʹ����ط�ֵ��λ��0��
%     figure(i);
% %     y = 0.25*ones(length(axis));
%     plot(axis,r(i,:));
%     xlim([-1 1]);%���ú����귶Χ
%     ylim([-1.3 1.3]);%���������귶Χ
%     title('α������еĻ��������');
%     xlabel('k');
%     ylabel('R(k)');
%     legend('gold�������������');
% end
% plot(AutocorSidPaPeak,'k-*')

goldseq1 = 2*goldseq(1,:)-1;%gold��ת����˫������
goldseq2 = 2*goldseq(3,:)-1;%gold��ת����˫������
goldseq3 = 2*goldseq(8,:)-1;%gold��ת����˫������
goldseq4 = 2*goldseq(9,:)-1;%gold��ת����˫������
goldseq5 = 2*goldseq(13,:)-1;%gold��ת����˫������
goldseq6 = 2*goldseq(14,:)-1;%gold��ת����˫������
goldseq7 = 2*goldseq(15,:)-1;%gold��ת����˫������
goldseq8 = 2*goldseq(18,:)-1;%gold��ת����˫������
goldseq9 = 2*goldseq(25,:)-1;%gold��ת����˫������

temp1 = goldseq9;
r1=ccorr(temp1,goldseq1);
r2=ccorr(temp1,goldseq2);
r3=ccorr(temp1,goldseq3);
r4=ccorr(temp1,goldseq4);
r5=ccorr(temp1,goldseq5);
r6=ccorr(temp1,goldseq6);
r7=ccorr(temp1,goldseq7);
r8=ccorr(temp1,goldseq8);
r9=ccorr(temp1,goldseq9);
AutocorSidPaPeak = [max(r1(33:63));max(r2(33:63));max(r3(33:63));max(r4(33:63));max(r5(33:63));max(r6(33:63));max(r7(33:63));max(r8(33:63));max(r9(33:63))];
max(AutocorSidPaPeak)

axis=-length(goldseq1)+1:length(goldseq1)-1;%�������ʹ����ط�ֵ��λ��0��
figure();
subplot(1,2,1);
plot(axis,r9);
% xlim([-1 1]);%���ú����귶Χ
ylim([-1.3 1.3]);%���������귶Χ
title('α������е����������');
xlabel('k');
ylabel('R(k)');
legend('gold�������������');
subplot(1,2,2);
plot(axis,r2);
% xlim([-20 20]);%���ú����귶Χ
ylim([-1.3 1.3]);%���������귶Χ
title('α������еĻ��������');
xlabel('k');
ylabel('R(k)');
legend('gold���л��������');

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