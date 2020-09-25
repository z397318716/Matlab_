[num1] = xlsread('PTU_R06_12.xlsx', 1, 'D3:Q1442' );    %���ݷ�Χ: D3-Q1442
[num2] = xlsread('VIS_R06_12.xlsx', 1, 'D3:Z5756' );    %���ݷ�Χ: D3-Z5757
[num3] = xlsread('WIND_R06_12.xlsx', 1, 'D3:W5757' );    %���ݷ�Χ: D3-W5757
% PTU----ÿ���Ӳɼ�1һ��, ��1440������      555 3�� 608 3��  812 3��  1062 3�� 1214 ����
% ���������ݶ���1��ɼ�4��,������Ҫ��PTU���е����ݽ�������,ÿ�������ظ�4��
x11 = (num1(:,1))';  % PAINS��HPA��   ��վ��ѹ
x22 = (num1(:,2))';  % QNH 			������ƽ����ѹ
x33 = (num1(:,4))';  % QFE R06  		�ɻ���½������ߵ���ѹ
x44 = (num1(:,11))'; % TEMP 			�¶�
x55 = (num1(:,12))'; % RH				���ʪ��
x66 = (num1(:,13))';    %DEWPOINT		¶���¶�

x1 = [];
x2 = [];
x3 = [];
x4 = [];
x5 = [];
x6 = [];
for i = 1:length(x11)
    if(i == 553 || i == 606 || i == 810 || i == 1060 || i == 1212)
        for i = 1: 3
            x1 = [x1,x11(i)];
            x2 = [x2,x22(i)];
            x3 = [x3,x33(i)];
            x4 = [x4,x44(i)];
            x5 = [x5,x55(i)];
            x6 = [x6,x66(i)];
        end
    else
        for i = 1: 4
            x1 = [x1,x11(i)];
            x2 = [x2,x22(i)];
            x3 = [x3,x33(i)];
            x4 = [x4,x44(i)];
            x5 = [x5,x55(i)];
            x6 = [x6,x66(i)];
        end
    end
end

% VIS
x7 = (num2(:,2))';  % RVR_1A 		1����ƽ��RVRֵ

x8 = (num2(:,10))';  % MOR_1A 		1����ƽ��MORֵ
x9 = (num2(:,21))';  % LIGHT_S		�ƹ�����
x7 = [x7, 125];
x8 = [x8, 50];
x9 = [x9, 10];
% 
x10 = (num3(:,3))';  % WS2A 		2����ƽ������
x11 = (num3(:,11))';  % WD2A		2����ƽ������
x12 = (num3(:,20))';  % CW2A		2����ƽ����ֱ����

input_train = [x1; x2; x3; x4; x5; x6; x9; x10; x11; x12];  %��������
%output_train = [x7; x8];  % �������
output_train = x7;  % �������
%outputData = x7;

% ��һ������,����mapminmax(x,ymin,ymax)������ʹ��ֵ��һ����[ymin,ymax]֮�� Ĭ��[-1, 1]
[inputData,inputps]=mapminmax(input_train);
[outputData,outputps]=mapminmax(output_train);

%TF1 = 'tansig';TF2 = 'logsig';
%TF1 = 'logsig';TF2 = 'purelin';
%TF1 = 'logsig';TF2 = 'logsig';
%TF1 = 'purelin';TF2 = 'purelin';
 
TF1='tansig';TF2='purelin';

% ʹ������,�����������-----
% �������� 12  �����������Ϊ 7 ��������Ϊ 2 
% ���㡢�����Ĵ��ݺ����ֱ�Ϊtansig��purelin��ʹ��trainlm����ѵ����
%net = newff(minmax(inputData),[9,2],{TF1 TF2},'traingdm');%���紴��
net = newff(inputData, outputData, 7, {'tansig', 'purelin'}, 'trainbr');
%net = fitnet(inputData, outputData, 9, {'tansig', 'purelin'}, 'trainlm');
% ��������
net.trainparam.goal = 0.0000001; %ѵ��Ŀ�꣺����������0.0001
net.trainparam.show = 4;    %ÿѵ��400��չʾһ�ν��
net.trainparam.epochs = 15000;  %���ѵ��������15000
net.trainParam.lr = 1.1;  %ѧϰ��
%net.divideFcn = '';

[net,tr] = train(net,inputData,outputData);%����matlab�����繤�����Դ���train����ѵ������

simout = sim(net,inputData); %����matlab�����繤�����Դ���sim�����õ������Ԥ��ֵ
figure;  %�½���ͼ���ڴ���
t=1:length(simout);

%��ͼ���Ա�ԭ�����ܼ������ݺ�����Ԥ����ܼ���
%subplot(2,1,1);
plot(t,outputData, 'r',t, simout(1,:),'b');title('1����ƽ��RVRֵ');
legend('ԭʼ����','�������');
%plot(t,x7, 'r')
% subplot(2,1,2);plot(t,outputData(2,:), 'r',t, simout(2,:),'b');title('1����ƽ��MORֵ');
%plot(t,x8, 'b')

%subplot(2,2,3);plot(t, simout(1,:),'b');title('�������_1����ƽ��RVRֵ');
%subplot(2,2,4);plot(t, simout(2,:),'b');title('�������_1����ƽ��MORֵ');
%subplot(2,2,3)
%plot(t,x7, 'r',t,simout,'b')