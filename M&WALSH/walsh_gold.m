%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% ̽��walsh���gold�������֮��Ĺ�ϵ
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
clear all;
close all;
clc;
N = 22;
fbconnection1 = [1 1 1 0 1];%��ԭ����ʽ
fbconnection2 = [1 0 1 1 1];%��ԭ����ʽ
initregister = [0 0 0 0 1];%�Ĵ�����ʼֵ
[mseq1,registers] = M_seq(fbconnection1,initregister);
[mseq2,registers] = M_seq(fbconnection2,initregister);
goldseq = gold_seq(mseq1,mseq2);
walshseq = walsh_seq(32);%����32�׵�Walsh�� ����32��

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
    wlash_gold_seq(i,:) = 2*wlash_gold_seq(i,:)-1;%walsh_gold��ת����˫������;
    r(i,:)=ccorr(wlash_gold_seq(1,:),wlash_gold_seq(i,:));
    CroCorPeak(i) = max(abs(r(i,:)));
    CroCorMean(i) = mean(abs(r(i,:)));
end

axis=-length(walshseq)+1:length(walshseq)-1;%�������ʹ����ط�ֵ��λ��0��
figure(1);
subplot(1,2,1);
plot(axis,r(1,:));
xlim([-10 10]);%���ú����귶Χ
ylim([-1.3 1.3]);%���������귶Χ
title('α������е����������');
xlabel('k');
ylabel('R(k)');
legend('wlash&gold�������������');
subplot(1,2,2);
plot(axis,r(2,:));
% xlim([-20 20]);%���ú����귶Χ
ylim([-1.3 1.3]);%���������귶Χ
title('α������еĻ��������');
xlabel('k');
ylabel('R(k)');
legend('wlash&gold���л��������');

figure(2);
plot(CroCorPeak);
title('22��walsh&gold�뻥��ط�ֵ����');
xlabel('k');
ylabel('����ط�ֵ');

figure(3);
plot(CroCorMean);
title('22��walsh&gold�뻥��ؾ�ֵ����');
xlabel('k');
ylabel('����ؾ�ֵ');