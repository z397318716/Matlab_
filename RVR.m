[num1] = xlsread('PTU_R06_12.xlsx', 1, 'D3:Q1442' );    %数据范围: D3-Q1442
[num2] = xlsread('VIS_R06_12.xlsx', 1, 'D3:Z5756' );    %数据范围: D3-Z5757
[num3] = xlsread('WIND_R06_12.xlsx', 1, 'D3:W5757' );    %数据范围: D3-W5757

% 只重复3次的数据位置 87(1:26) 481(8:00) 637(10:36) 742(12:21) 1399(23:18)
[num11] = xlsread('PTU_R06_15.xlsx', 1, 'D3:Q1442' );    %数据范围: D3-Q1442
[num22] = xlsread('VIS_R06_15.xlsx', 1, 'D3:Z5756' );    %数据范围: D3-Z5757
[num33] = xlsread('WIND_R06_15.xlsx', 1, 'D3:W5757' );    %数据范围: D3-W5757

% PTU----每分钟采集1一次, 共1440组数据    75(1:12) 3次 608(10:05) 3次  812(13:29) 3次  1062(17:39) 3次 1214(20:11) 三次
% 而其它数据都是1秒采集4次,所以需要对PTU表中的数据进行扩充,每个数字重复4次
x1_1 = (num1(:,1))';  % PAINS（HPA）   本站气压
x2_2 = (num1(:,2))';  % QNH 			修正海平面气压
x3_3 = (num1(:,4))';  % QFE R06  		飞机着陆地区最高点气压
x4_4 = (num1(:,11))'; % TEMP 			温度
x5_5 = (num1(:,12))'; % RH				相对湿度
x6_6 = (num1(:,13))';    %DEWPOINT		露点温度

x1 = [];
x2 = [];
x3 = [];
x4 = [];
x5 = [];
x6 = [];
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
for i = 1:length(x1_1)
    if(i == 73 || i == 606 || i == 810 || i == 1060 || i == 1212)
        for i = 1: 3
            x1 = [x1,x1_1(i)];
            x2 = [x2,x2_2(i)];
            x3 = [x3,x3_3(i)];
            x4 = [x4,x4_4(i)];
            x5 = [x5,x5_5(i)];
            x6 = [x6,x6_6(i)];
        end
    else
        for i = 1: 4
            x1 = [x1,x1_1(i)];
            x2 = [x2,x2_2(i)];
            x3 = [x3,x3_3(i)];
            x4 = [x4,x4_4(i)];
            x5 = [x5,x5_5(i)];
            x6 = [x6,x6_6(i)];
        end
    end
end

d1_1 = (num11(:,1))';  % PAINS（HPA）   本站气压
d2_2 = (num11(:,2))';  % QNH 			修正海平面气压
d3_3 = (num11(:,4))';  % QFE R06  		飞机着陆地区最高点气压
d4_4 = (num11(:,11))'; % TEMP 			温度
d5_5 = (num11(:,12))'; % RH				相对湿度
d6_6 = (num11(:,13))';    %DEWPOINT		露点温度
d1 = [];
d2 = [];
d3 = [];
d4 = [];
d5 = [];
d6 = [];

d7 = (num22(:,2))';  % RVR_1A 		1分钟平均RVR值
d8 = (num22(:,10))';  % MOR_1A 		1分钟平均MOR值
d9 = (num22(:,21))';  % LIGHT_S		灯光数据
d7 = [d7, 200];
d8 = [d8, 50];
d9 = [d9, 100];
% 
d10 = (num33(:,3))';  % WS2A 		2分钟平均风速
d11 = (num33(:,11))';  % WD2A		2分钟平均风向
d12 = (num33(:,20))';  % CW2A		2分钟平均垂直风速
% 只重复3次的数据位置 87(1:26) 481(8:00) 637(10:36) 742(12:21) 1399(23:18)
for ii = 1:length(d1_1)
    if( ii== 87 || ii == 481 || ii == 637 || ii == 742 || ii == 1399)
        for ii = 1: 3
            d1 = [d1,d1_1(ii)];
            d2 = [d2,d2_2(ii)];
            d3 = [d3,d3_3(ii)];
            d4 = [d4,d4_4(ii)];
            d5 = [d5,d5_5(ii)];
            d6 = [d6,d6_6(ii)];
        end
    else
        for ii = 1: 4
            d1 = [d1,d1_1(ii)];
            d2 = [d2,d2_2(ii)];
            d3 = [d3,d3_3(ii)];
            d4 = [d4,d4_4(ii)];
            d5 = [d5,d5_5(ii)];
            d6 = [d6,d6_6(ii)];
        end
    end
end

x1 = [x1, d1];
x2 = [x2, d2];
x3 = [x3, d3];
x4 = [x4, d4];
x5 = [x5, d5];
x6 = [x6, d6];
x7 = [x7, d7];
x8 = [x8, d8];
x9 = [x9, d9];
x10 = [x10, d10];
x11 = [x11, d11];
x12 = [x12, d12];

input_train = [x1; x2; x3; x4; x5; x6; x9; x10; x11; x12];  %输入数据
%output_train = [x7; x8];  % 输出数据
output_train = x7;  % 输出数据
%outputData = x7;

% 归一化处理,利用mapminmax(x,ymin,ymax)函数，使数值归一化到[ymin,ymax]之间 默认[-1, 1]
% ps处理设置，ps主要在结果反归一化中需要调用，或者使用同样的settings归一化另外一组数据
[inputData,ps]=mapminmax(input_train);
[outputData,ts]=mapminmax(output_train);
%---------------------------------------------------
%数据乱序，及分类处理
%将输入的5755组数据的20%，即1151组，用来作为测试数据；
% 样本的20%，即1151组，用来作为变化数据；
%另外3453组用来正常输入，用来训练；
%dividevec()用来重新随机抽取上述三种分类的数据，原来的顺序被打乱
%函数调用的语法
%[trainV,valV,testV] = dividevec(p,t,valPercent,testPercent)
%输入p为输入数据，t为输出数据
%valPercent为训练用的变化数据在总输入中的百分比
%testPercent为训练用的测试数据在总输入中的百分比
%输出trainV,valV,testV分别为按乱序及相应百分比，抽取得到的数据
%另外，打乱后的数据，p和t都是对应的
%---------------------------------------------------
testPercent = 0.10;  % Adjust as desired
validatePercent = 0.10;  % Adust as desired
[trainSamples,validateSamples,testSamples] = dividevec(inputData,outputData,validatePercent,testPercent);
TF1 = 'tansig';TF2 = 'tansig'; TF3 = 'tansig';%各层传输函数，TF3为输出层传输函数
%各类传输函数
%TF1 = 'tansig';TF2 = 'logsig';
%TF1 = 'logsig';TF2 = 'purelin';
%TF1 = 'tansig';TF2 = 'tansig';
%TF1 = 'logsig';TF2 = 'logsig';
%TF1 = 'purelin';TF2 = 'purelin';
All_error = [];
for j = 1:10
    NodeNum1 = 8; % 隐层第一层节点数
    NodeNum2 = 5;   % 隐层第二层节点数
    TypeNum = 1;   % 输出维数
    % 使用输入,输出建立网络-----
    % 输入层个数 12  隐含层个数设为 7 输出层个数为 2
    net=newff(minmax(inputData),[NodeNum2,TypeNum],{TF2 TF3},'traingdx');%网络创建
    %net=newff(minmax(inputData),[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'traingdx');%网络创建
    %net = newff(minmax(inputData),[9,2],{TF1 TF2},'traingdm');%网络创建
    %net = newff(inputData, outputData, 8, {'tansig', 'purelin'}, 'trainbr');
    %net = fitnet(inputData, outputData, 9, {'tansig', 'purelin'}, 'trainlm');
    % 参数设置
    net.trainparam.goal = 1e-6; %训练目标：均方误差低于
    net.trainparam.show = 8;    %每训练400次展示一次结果
    net.trainparam.epochs = 15000;  %最大训练次数：15000
    net.trainParam.lr = 0.005;  %学习率,应设置为较少值，太大虽然会在开始加快收敛速度，但临近最佳点时，会产生动荡，而致使无法收敛
    %net.divideFcn = '';
    
    %---------------------------------------------------
    % 指定训练参数
    %---------------------------------------------------
    % net.trainFcn = 'traingd'; % 梯度下降算法
    % net.trainFcn = 'traingdm'; % 动量梯度下降算法
    %
    % net.trainFcn = 'traingda'; % 变学习率梯度下降算法
    % net.trainFcn = 'traingdx'; % 变学习率动量梯度下降算法
    %
    % (大型网络的首选算法)
    % net.trainFcn = 'trainrp'; % RPROP(弹性BP)算法,内存需求最小
    %
    % (共轭梯度算法)
    % net.trainFcn = 'traincgf'; % Fletcher-Reeves修正算法
    % net.trainFcn = 'traincgp'; % Polak-Ribiere修正算法,内存需求比Fletcher-Reeves修正算法略大
    % net.trainFcn = 'traincgb'; % Powell-Beal复位算法,内存需求比Polak-Ribiere修正算法略大
    %
    % (大型网络的首选算法)
    %net.trainFcn = 'trainscg'; % Scaled Conjugate Gradient算法,内存需求与Fletcher-Reeves修正算法相同,计算量比上面三种算法都小很多
    % net.trainFcn = 'trainbfg'; % Quasi-Newton Algorithms - BFGS Algorithm,计算量和内存需求均比共轭梯度算法大,但收敛比较快
    % net.trainFcn = 'trainoss'; % One Step Secant Algorithm,计算量和内存需求均比BFGS算法小,比共轭梯度算法略大
    %
    % (中型网络的首选算法)
    %net.trainFcn = 'trainlm'; % Levenberg-Marquardt算法,内存需求最大,收敛速度最快
    % net.trainFcn = 'trainbr'; % 贝叶斯正则化算法
    %
    % 有代表性的五种算法为:'traingdx','trainrp','trainscg','trainoss', 'trainlm'
    
    net.trainFcn = 'traingda'; % 变学习率梯度下降算法
    %net.trainfcn='trainlm';
    [net,tr] = train(net,trainSamples.P,trainSamples.T,[],[],validateSamples,testSamples);
    %[net,tr] = train(net,inputData,outputData);%调用matlab神经网络工具箱自带的train函数训练网络
    
    %调用matlab神经网络工具箱自带的sim函数得到网络的预测值
    %simout = sim(net,inputData);
    %正常输入的3453组p数据，BP得到的结果t
    %[normTrainOutput,Pf,Af,E,trainPerf] = sim(net,trainSamples.P,[],[],trainSamples.T);
    [normTrainOutput,trainPerf] = sim(net,trainSamples.P,[],[],trainSamples.T);
    %用作变量1151的数据p，BP得到的结果t
    [normValidateOutput,validatePerf] = sim(net,validateSamples.P,[],[],validateSamples.T);
    %[normValidateOutput,Pf,Af,E,validatePerf] = sim(net,validateSamples.P,[],[],validateSamples.T);
    %用作测试的1151组数据p，BP得到的结果t
    [normTestOutput,testPerf] = sim(net,testSamples.P,[],[],testSamples.T);
    %[normTestOutput,Pf,Af,E,testPerf] = sim(net,testSamples.P,[],[],testSamples.T);
    
    %---------------------------------------------------
    % 仿真后结果数据反归一化，如果需要预测，只需将预测的数据P填入
    % 将获得预测结果t
    %---------------------------------------------------
    trainOutput = mapminmax('reverse',normTrainOutput,ts);  % 正常输入的3453组p数据，BP得到的反归一化后的结果t
    trainInsect = mapminmax('reverse',trainSamples.T,ts);   % 正常输入的3453组数据t
    validateOutput = mapminmax('reverse',normValidateOutput,ts);% 用作变量1151的数据p，BP得到的归一化的结果t
    validateInsect = mapminmax('reverse',validateSamples.T,ts); % 用作变量1151的数据t
    testOutput = mapminmax('reverse',normTestOutput,ts);    % 用作测试1151组数据p，BP得到的归一化的结果t
    testInsect = mapminmax('reverse',testSamples.T,ts);     % 用作变量1151组数据t
    
    %绝对误差计算
    absTrainError = trainOutput-trainInsect;
    absTestError = testOutput-testInsect;
    error_sum = sqrt(absTestError(1).^2+absTestError(2).^2+absTestError(3).^2);
    %All_error = [];
    All_error = [All_error, error_sum];
    eps=90;%其为3组测试数据的标准差，或者每个数据偏差在一定范围内而判别
    if ((abs(absTestError(1))<=30 )&&(abs(absTestError(2))<=30)&&(abs(absTestError(3))<=30)||(error_sum<=eps))
        save mynetdata net
        break
    end
    j
end
j
%Min_error_sqrt = min(All_error)

testOutput
testInsect

%---------------------------------------------------
% 数据分析和绘图
%---------------------------------------------------  
figure
t = 1:length(trainOutput);
k = 1:length(validateOutput);
subplot(2,1,1);
plot(t,trainOutput,t,trainInsect);
legend('真实数据预测结果','真实数据');
subplot(2,1,2);
plot(k,validateInsect,'g--',k,validateOutput,'b-',k,testInsect,'ro' ,k,testOutput,'m*');
legend('变化数据原始值','变化数据BP预测值','测试数据原始值','测试数据BP预测值');

ylabel('能见度MOR');

figure
xx=1:length(All_error);
plot(xx,All_error)
title('误差变化图')
w12 = net.iw{1,1} %第1层（输入层）到第2层（隐层）的权值
b2 = net.b{1}    %第2层（隐层）的阈值

w23 = net.lw{2,1} %第2层（输入层）到第3层（输出层）的权值
b3 = net.b{2}    %第3层（输出层）的阈值


% figure;  %新建画图窗口窗口
% t=1:length(simout);
% 
% %画图，对比原来的能见度数据和网络预测的能见度
% %subplot(2,1,1);
% plot(t,outputData, 'r',t, simout,'b');title('1分钟平均MOR值');
% legend('原始数据','拟合数据');
% %plot(t,x7, 'r')
% % subplot(2,1,2);plot(t,outputData(2,:), 'r',t, simout(2,:),'b');title('1分钟平均MOR值');
% %plot(t,x8, 'b')
% 
% %subplot(2,2,3);plot(t, simout(1,:),'b');title('拟合数据_1分钟平均RVR值');
% %subplot(2,2,4);plot(t, simout(2,:),'b');title('拟合数据_1分钟平均MOR值');
% %subplot(2,2,3)
% %plot(t,x7, 'r',t,simout,'b')