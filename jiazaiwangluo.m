%%�������磬�Ժ�������ʽ
function jiazaiwangluo()
%�������,ע���ļ���Ҫ�ӵ�����
load('-mat','deep_model'); 
load ('set.mat');

%��ָ��Ŀ¼���ء�load('-mat','d:\aaa.mat'); ��
% str1 = 'G:\2020_math_model_code\picture\';
% str2 = '.jpg';
str1 = 'G:\2020_math_model_code\pre_picture\original_frame';
str2 = '.bmp';
D = huidu(1, 100, str1, str2);    % �ҶȾ���������
T = tidu(1, 100, str1, str2);     % �ݶ�����
% 1863 : 2773


pre_data = [D;T];
% ��һ��
[inputData,ps]=mapminmax(pre_data);
%����matlab�����繤�����Դ���sim�����õ������Ԥ��ֵ
simout = sim(net,inputData);
%pre_out= sim(net,pre_data);
pre_out = mapminmax('reverse',simout,ts);
process_data = [];
for i = 1 : length(pre_data)
   tmp =  pre_data(i)/10;

   process_data = [process_data, tmp];
end
t = 1:length(pre_out);
figure();
plot(t, pre_out);
xlabel('ʱ������');ylabel('�ܼ���MOR_1A');
%set(gca,'xticklabel',{'00:00:00';' ';'3:08:30';' ';'6:17:00';' ';'9:25:30'});
legend('��ʵ������Ͻ��','��ʵ����');
title('������ݽ��');

figure();
plot(t, process_data);
axis([0 101 0 200])
xlabel('ʱ������');ylabel('�ܼ���');
% m=linspace(datenum('6:00','HH:MM'),datenum('12:00','HH:MM'),13); 
% set(gca,'xtick',6:0.5:12); 
% for n=1:length(m) 
%     tm{n}=datestr(m(n),'HH:MM'); 
% end 
% set(gca,'xticklabel',tm);


% ���� �Աȶ� �ݶ� �ҶȾ������+��������   bp   ������ ʹ�� ��Ƶ���� ����Ӧ���ܼ���ֵѵ��
