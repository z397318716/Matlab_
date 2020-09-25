% ʹ��MNIST���ݼ�������д�������ֵ�ʶ��
close all
clear all
setdemorandstream(pi);      %����������ӣ��и��д������ʹÿ�����н������һ��
% 1.��������
load MNIST.mat
% 2.��ʼ��������
hiddenSizes = 120;                   %���ز���
net = patternnet(hiddenSizes);       %��ʼ��ģʽʶ��������
net.layers{1}.transferFcn = 'logsig';
net.trainFcn = 'traincgf';
% 3.ѵ��������
net = train(net,TRAIN_images',TRAIN_labels'); %ѵ������
view(net)                                     %�鿴������ṹ
% 4.ʹ�ò��Լ����з���
testLen = 10000;                     %���Լ�����
val = sim(net,TEST_images');                %������Լ�������
classes = vec2ind(val);              %��������ת��Ϊclass
r = sum(classes == label2class(TEST_labels'))/(testLen);  %������ȷ�ʣ�label2class��Դ���ȡ��ַΪhttps://item.taobao.com/item.htm?id=617991363481
disp(['ģʽʶ�����ȷ��Ϊ',num2str(r)]) %��ӡ���

% ������2~4���������ʹ��һ�з�װ�õĺ�������ʵ�֣�
% fastPatternnet(TRAIN_images,TRAIN_labels,TEST_images,TEST_labels,120,'on',[])

% -�ú���������Կ���ʵ������Ҫ��ɵķ��๤��
% -�����Զ������������з�����������
% -����ʽ���ã��ʺ�С������
% -��������

% ����ȡ�÷�װ�õġ�����������������ʵ�֡��Ĵ�����Կ����https://item.taobao.com/item.htm?id=617991363481
% ���ڸù��߸�������������http://www.khscience.cn/docs/index.php/2020/05/03/network-2/







