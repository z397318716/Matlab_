[num1] = xlsread('PTU_R06_12.xlsx', 1, 'D3:Q1442' );    %数据范围: D3-Q1442
[num2] = xlsread('VIS_R06_12.xlsx', 1, 'D3:Z5756' );    %数据范围: D3-Z5757
[num3] = xlsread('WIND_R06_12.xlsx', 1, 'D3:W5757' );    %数据范围: D3-W5757
% PTU----每分钟采集1一次, 共1440组数据      555 3次 608 3次  812 3次  1062 3次 1214 三次
% 而其它数据都是1秒采集4次,所以需要对PTU表中的数据进行扩充,每个数字重复4次
x11 = (num1(:,1))';  % PAINS（HPA）   本站气压
x22 = (num1(:,2))';  % QNH 			修正海平面气压
x33 = (num1(:,4))';  % QFE R06  		飞机着陆地区最高点气压
x44 = (num1(:,11))'; % TEMP 			温度
x55 = (num1(:,12))'; % RH				相对湿度
x66 = (num1(:,13))';    %DEWPOINT		露点温度

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
x7 = (num2(:,2))';  % RVR_1A 		1分钟平均RVR值

x8 = (num2(:,10))';  % MOR_1A 		1分钟平均MOR值
x9 = (num2(:,21))';  % LIGHT_S		灯光数据
x7 = [x7, 125];
x8 = [x8, 50];
x9 = [x9, 10];
% 
x10 = (num3(:,3))';  % WS2A 		2分钟平均风速
x11 = (num3(:,11))';  % WD2A		2分钟平均风向
x12 = (num3(:,20))';  % CW2A		2分钟平均垂直风速

input_train = [x1; x2; x3; x4; x5; x6; x9; x10; x11; x12];  %输入数据
%output_train = [x7; x8];  % 输出数据
output_train = x7;  % 输出数据
%outputData = x7;

% 归一化处理,利用mapminmax(x,ymin,ymax)函数，使数值归一化到[ymin,ymax]之间 默认[-1, 1]
[inputData,inputps]=mapminmax(input_train);
[outputData,outputps]=mapminmax(output_train);

%TF1 = 'tansig';TF2 = 'logsig';
%TF1 = 'logsig';TF2 = 'purelin';
%TF1 = 'logsig';TF2 = 'logsig';
%TF1 = 'purelin';TF2 = 'purelin';
 
TF1='tansig';TF2='purelin';

% 使用输入,输出建立网络-----
% 输入层个数 12  隐含层个数设为 7 输出层个数为 2 
% 隐层、输出层的传递函数分别为tansig和purelin，使用trainlm方法训练。
%net = newff(minmax(inputData),[9,2],{TF1 TF2},'traingdm');%网络创建
net = newff(inputData, outputData, 7, {'tansig', 'purelin'}, 'trainbr');
%net = fitnet(inputData, outputData, 9, {'tansig', 'purelin'}, 'trainlm');
% 参数设置
net.trainparam.goal = 0.0000001; %训练目标：均方误差低于0.0001
net.trainparam.show = 4;    %每训练400次展示一次结果
net.trainparam.epochs = 15000;  %最大训练次数：15000
net.trainParam.lr = 1.1;  %学习率
%net.divideFcn = '';

[net,tr] = train(net,inputData,outputData);%调用matlab神经网络工具箱自带的train函数训练网络

simout = sim(net,inputData); %调用matlab神经网络工具箱自带的sim函数得到网络的预测值
figure;  %新建画图窗口窗口
t=1:length(simout);

%画图，对比原来的能见度数据和网络预测的能见度
%subplot(2,1,1);
plot(t,outputData, 'r',t, simout(1,:),'b');title('1分钟平均RVR值');
legend('原始数据','拟合数据');
%plot(t,x7, 'r')
% subplot(2,1,2);plot(t,outputData(2,:), 'r',t, simout(2,:),'b');title('1分钟平均MOR值');
%plot(t,x8, 'b')

%subplot(2,2,3);plot(t, simout(1,:),'b');title('拟合数据_1分钟平均RVR值');
%subplot(2,2,4);plot(t, simout(2,:),'b');title('拟合数据_1分钟平均MOR值');
%subplot(2,2,3)
%plot(t,x7, 'r',t,simout,'b')