% 使用MNIST数据集进行手写字体数字的识别
close all
clear all
setdemorandstream(pi);      %设置随机种子，有该行代码可以使每次运行结果保持一致
% 1.加载数据
load MNIST.mat
% 2.初始化神经网络
hiddenSizes = 120;                   %隐藏层数
net = patternnet(hiddenSizes);       %初始化模式识别神经网络
net.layers{1}.transferFcn = 'logsig';
net.trainFcn = 'traincgf';
% 3.训练神经网络
net = train(net,TRAIN_images',TRAIN_labels'); %训练网络
view(net)                                     %查看神经网络结构
% 4.使用测试集进行分类
testLen = 10000;                     %测试集长度
val = sim(net,TEST_images');                %计算测试集分类结果
classes = vec2ind(val);              %将分类结果转换为class
r = sum(classes == label2class(TEST_labels'))/(testLen);  %计算正确率，label2class的源码获取地址为https://item.taobao.com/item.htm?id=617991363481
disp(['模式识别的正确率为',num2str(r)]) %打印结果

% 上述从2~4步程序可以使用一行封装好的函数程序实现：
% fastPatternnet(TRAIN_images,TRAIN_labels,TEST_images,TEST_labels,120,'on',[])

% -该函数程序可以快速实现你想要完成的分类工作
% -可以自动纠正数据行列方向错误的问题
% -简易式调用，适合小白入手
% -持续更新

% 获需取该封装好的“神经网络分类任务快速实现”的代码可以看这里：https://item.taobao.com/item.htm?id=617991363481
% 关于该工具更多的描述在这里：http://www.khscience.cn/docs/index.php/2020/05/03/network-2/







