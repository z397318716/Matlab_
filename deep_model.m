readdata();     % 读数据
str1 = 'G:\2020_math_model_code\picture\';
str2 = '.jpg';
D = huidu(1, 1862, str1, str2);    % 灰度均方差数据
T = tidu(1, 1862, str1, str2);     % 梯度数据

input_train = [D;T];  
%input_train = [x1; x2; x3; x4; x5; x6; x9; x10; x11; x12];  %输入数据---10个变量都考虑
%output_train = [x7; x8];  % 输出数据
output_train = Visibility;  % 输出数据
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
absTrainError = [];
absTestError = [];
count = 10;
for j = 1:count
    NodeNum1 = 7; % 隐层第一层节点数
    NodeNum2 = 7;   % 隐层第二层节点数
    TypeNum = 1;   % 输出维数
    % 使用输入,输出建立网络-----
    % 输入层个数 12  隐含层个数设为 7 输出层个数为 2
    %net=newff(minmax(inputData),[NodeNum2,TypeNum],{TF2 TF3},'trainlm');%网络创建
    net=newff(minmax(inputData),[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'traingdx');%网络创建
    %net = newff(minmax(inputData),[9,2],{TF1 TF2},'traingdm');%网络创建
    %net = newff(inputData, outputData, 4, {'tansig', 'tansig'}, 'traingdx');
    %net = fitnet(inputData, outputData, 9, {'tansig', 'purelin'}, 'traincgp');
    % 参数设置
    net.trainparam.goal = 1e-6; %训练目标：均方误差低于
    net.trainparam.show = 8;    %每训练400次展示一次结果
    net.trainparam.epochs = 15000;  %最大训练次数：15000
    net.trainParam.lr = 0.001;  %学习率,应设置为较少值，太大虽然会在开始加快收敛速度，但临近最佳点时，会产生动荡，而致使无法收敛
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
    %net.trainFcn = 'trainrp'; % RPROP(弹性BP)算法,内存需求最小
    %
    % (共轭梯度算法)
    % net.trainFcn = 'traincgf'; % Fletcher-Reeves修正算法
    % net.trainFcn = 'traincgp'; % Polak-Ribiere修正算法,内存需求比Fletcher-Reeves修正算法略大
    % net.trainFcn = 'traincgb'; % Powell-Beal复位算法,内存需求比Polak-Ribiere修正算法略大
    %
    % (大型网络的首选算法)
    % net.trainFcn = 'trainscg'; % Scaled Conjugate Gradient算法,内存需求与Fletcher-Reeves修正算法相同,计算量比上面三种算法都小很多
    % net.trainFcn = 'trainbfg'; % Quasi-Newton Algorithms - BFGS Algorithm,计算量和内存需求均比共轭梯度算法大,但收敛比较快
    % net.trainFcn = 'trainoss'; % One Step Secant Algorithm,计算量和内存需求均比BFGS算法小,比共轭梯度算法略大
    %
    % (中型网络的首选算法)
    net.trainFcn = 'trainlm'; % Levenberg-Marquardt算法,内存需求最大,收敛速度最快
    % net.trainFcn = 'trainbr'; % 贝叶斯正则化算法
    %
    % 有代表性的五种算法为:'traingdx','trainrp','trainscg','trainoss', 'trainlm'
    
    %net.trainFcn = 'traingda'; % 变学习率梯度下降算法
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
    if j == 1
        absTrainError = trainOutput - trainInsect;
        absTestError = testOutput - testInsect;
    else
        absTrainError =absTrainError + (trainOutput - trainInsect);    % 训练误差序列
        absTestError = absTestError + (testOutput - testInsect);       % 测试数据的误差序列
    end
%     %error_sum = sqrt(absTestError(1).^2+absTestError(2).^2+absTestError(3).^2);
%     %All_error = [];
%     All_error = [All_error, error_sum];
%     eps=90;%其为3组测试数据的标准差，或者每个数据偏差在一定范围内而判别
%     if ((abs(absTestError(1))<=30 )&&(abs(absTestError(2))<=30)&&(abs(absTestError(3))<=30)||(error_sum<=eps))
%         save mynetdata net
%         break
%     end
    j
end
j
%Min_error_sqrt = min(All_error)
absTrainError = absTrainError / count;
aver_train_error = sum(abs(absTrainError))/length(absTrainError);
absTestError = absTestError / count;
aver_test_error = sum(abs(absTestError))/length(absTestError);
testOutput;
testInsect;

%保存训练好的网络在当前工作目录下的deep_model 文件中，net为网络名
save('deep_model', 'net');
save('set', 'ts','ps');


%---------------------------------------------------
% 数据分析和绘图
%---------------------------------------------------  
figure
t = 1:length(trainOutput);
k = 1:length(validateOutput);
%subplot(2,1,1);
plot(t,trainOutput,t,trainInsect);
xlabel('时间序列');ylabel('能见度MOR_1A');
legend('预测值','实际值');
%subplot(2,1,2);
figure
%plot(k,validateInsect,'g--',k,validateOutput,'b-',k,testInsect,'ro' ,k,testOutput,'m*');
plot(k,testInsect,'ro' ,k,testOutput,'m*');
%legend('变化数据原始值','变化数据BP预测值','测试数据原始值','测试数据BP预测值');
legend('测试数据实际值','测试数据预测值');
xlabel('时间序列');ylabel('能见度MOR_1A');

figure
xx=1:length(absTrainError);

plot(xx,absTrainError);
xlabel('时间序列');ylabel('能见度MOR_1A');
%text(15,15,['平均误差',num2str(aver_train_error)])
title('训练数据误差');
figure
yy=1:length(absTestError);
plot(yy,absTestError);
xlabel('时间序列');ylabel('能见度MOR_1A');
%text(6,6,['平均误差',num2str(aver_test_error)])
title('测试数据误差');

aver_train_error %平均训练误差
aver_test_error  %平均测试误差

% D=[];
% N = 
% % 2774张图片(每隔15秒采集一次)
% % 视频起始时间 00:00:26  对应 VIS_R06_12 3842行数据 2020/3/13  0:00:30
% for k=1:1:466
%     imageName=strcat(num2str(k),'.jpg');
%     i=imread(imageName); %载入真彩色图像
%     i=rgb2gray(i); %转换为灰度图
%     i=double(i);  %将uint8型转换为double型，否则不能计算统计量
%     % sq1=var(i,0,1); %列向量方差，第二个参数为0，表示方差公式分子下面是n-1,如果为1则是n
%     % sq2=var(i,0,2); %行向量方差
%     avg=mean2(i);  %求图像均值
%     [m,n]=size(i);
%     s=0;
%     for x=1:m
%         for y=1:n
%             s=s+(i(x,y)-avg)^2; %求得所有像素与均值的平方和。
%         end
%     end
%     B=sqrt(s/(m*n));
%     D=[D,B];  %灰度均方值
%     
% end
% t=1:466;
% % plot(t,D,'r');
% % [inputdata,intputs]=mapminmax(D);%归一化
% % plot(t,inputdata,'r');
% 
%  hold on;
% 
% data=[];
% [num1]=xlsread('1.xlsx',1,'D3840:Q5757');
% x11=(num1(:,2));
% for i=1:4:1864
%     data =[data,x11(i)];  %能见度
% end
% plot(t,data,'g');
% % [inputdata,intputs]=mapminmax(data);%归一化
% % plot(t,inputdata,'g');