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
temp1 = [];
for i = 1:31    
    shift = 25;
    temp(i,1:shift-1) = goldseq(i,1:shift-1);
    temp(i,shift) = 0;
    temp(i,shift+1:32) = goldseq(i,shift:31);
end
goldseq = temp;

for i = 1:length(goldseq)-1
    temp = 0;
    for j=1:length(goldseq(i,:))
        temp = temp + goldseq(i,j)*2^(j-1);
    end
    goldseq_hex(i,:) = dec2hex(temp,8);
%     goldseq(i,:) = 2*goldseq(i,:)-1;%gold��ת����˫������
%     r(i,:)=ccorr(goldseq(i,:));
%     AutocorSidPaPeak = [AutocorSidPaPeak max(r(i,33:63))];
%     axis=-length(goldseq)+1:length(goldseq)-1;%�������ʹ����ط�ֵ��λ��0��
%     figure(i);
% %     y = 0.25*ones(length(axis));
%     plot(axis,r(i,:));
% %     xlim([-1 1]);%���ú����귶Χ
%     ylim([-1.3 1.3]);%���������귶Χ
%     title('α������е����������');
%     xlabel('k');
%     ylabel('R(k)');
%     legend('gold�������������');
end
% plot(AutocorSidPaPeak,'k-*');

goldseqTemp = [];
goldseqTemp(1,:) = 2*goldseq(2,:)-1;%gold��ת����˫�����룻
goldseqTemp(2,:) = 2*goldseq(3,:)-1;%gold��ת����˫������
goldseqTemp(3,:) = 2*goldseq(4,:)-1;%gold��ת����˫������
goldseqTemp(4,:) = 2*goldseq(5,:)-1;%gold��ת����˫������
goldseqTemp(5,:) = 2*goldseq(29,:)-1;%gold��ת����˫������
goldseqTemp(6,:) = 2*goldseq(7,:)-1;%gold��ת����˫������
goldseqTemp(7,:) = 2*goldseq(8,:)-1;%gold��ת����˫������
goldseqTemp(8,:) = 2*goldseq(9,:)-1;%gold��ת����˫������
goldseqTemp(9,:) = 2*goldseq(10,:)-1;%gold��ת����˫������
goldseqTemp(10,:) = 2*goldseq(12,:)-1;%gold��ת����˫������
goldseqTemp(11,:) = 2*goldseq(13,:)-1;%gold��ת����˫������
goldseqTemp(12,:) = 2*goldseq(15,:)-1;%gold��ת����˫������
goldseqTemp(13,:) = 2*goldseq(16,:)-1;%gold��ת����˫������
goldseqTemp(14,:) = 2*goldseq(17,:)-1;%gold��ת����˫������
goldseqTemp(15,:) = 2*goldseq(19,:)-1;%gold��ת����˫������
goldseqTemp(16,:) = 2*goldseq(20,:)-1;%gold��ת����˫������
goldseqTemp(17,:) = 2*goldseq(22,:)-1;%gold��ת����˫������
goldseqTemp(18,:) = 2*goldseq(24,:)-1;%gold��ת����˫������
goldseqTemp(19,:) = 2*goldseq(25,:)-1;%gold��ת����˫������
goldseqTemp(20,:) = 2*goldseq(26,:)-1;%gold��ת����˫������
goldseqTemp(21,:) = 2*goldseq(27,:)-1;%gold��ת����˫������
goldseqTemp(22,:) = 2*goldseq(28,:)-1;%gold��ת����˫������

for i = 1:22
    AutocorSidPaPeak = [];
    for j = 1:22
        r(j,:) = ccorr(goldseqTemp(i,:),goldseqTemp(j,:));
        AutocorSidPaPeak = [AutocorSidPaPeak max(r(j,33:63))];
    end
    temp1 = [temp1 max(AutocorSidPaPeak)];
end

% 
% axis=-length(goldseq1)+1:length(goldseq1)-1;%�������ʹ����ط�ֵ��λ��0��
% figure();
% subplot(1,2,1);
% plot(axis,r9);
% % xlim([-1 1]);%���ú����귶Χ
% ylim([-1.3 1.3]);%���������귶Χ
% title('α������е����������');
% xlabel('k');
% ylabel('R(k)');
% legend('gold�������������');
% subplot(1,2,2);
% plot(axis,r2);
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