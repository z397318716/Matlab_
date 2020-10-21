clc;
clear;
%% 读数据
[x1, x2, x3, x4, x5, x6, x7, x8] = readFingerprint();
outdata  = [x1';x2'];     %注意中间是分号
indata  = [x3'; x4'; x5'; x6'; x7'; x8'];

%% 中值滤波
% indata_1  = [x3'; x4'; x5'; x6'; x7'; x8'];
% indata = medfilt2(indata_1,[3,3]);   % 中值滤波
% indata(1,1) = -38;
% indata(6,1) = -68;
% indata(1,1015) = -72;
% indata(6,1015) = -66;

%%
% 取偶数行数据作为训练, 奇数行作为测试
% 间隔k个数据取一组数据作为测试数据,其余作为训练数据
% 训练数据:812    测试数据: 203
k = 10;
n = 21:k:1015;   % 取测试数据
m = 1:1:1015;   % 取训练数据
for j = 1:length(indata)
    if(j < 913 && mod(m(j),k) == 1)
       m(j) = []; 
    end
end
traindata = indata(:,m);
trainoutdata = outdata(:,m);
testdata = indata(:,n);
testoutdata = outdata(:,n);
% %% 数据归一化处理
% [input, ps] = mapminmax(indata');
% [output, ts] = mapminmax(outdata');
%%
res_goal = [];
res_spread = [];
res_err = [];
res_05err = [];
res_1err = [];
res_2err = [];
res_3err = [];
for goal = 0.76:0.01:0.76
    for spread = 12:1:12
        net = newrb(traindata, trainoutdata, goal, spread);    %以X，Y建立径向基网络，目标误差为0.01，径向基的spread=2
        %net = newrbe(traindata, trainoutdata, 6);
        simY = sim(net, traindata);        %用建好的网络拟合原始数据
        % 用训练好的网络训练数据
        simtest = sim(net, testdata);
        %% 反归一化
        % out_data = mapminmax('reverse',simY,ts);
        % %% 输出各层连接权值/阈值
        % w12 = net.iw{1,1} %第1层（输入层）到第2层（隐层）的权值
        % b2 = net.b{1}    %第2层（隐层）的阈值
        %
        % w23 = net.lw{2,1} %第2层（输入层）到第3层（输出层）的权值
        % b3 = net.b{2}    %第3层（输出层）的阈值
        
        %t = 1:size(output);
        trainx = simY(1,:);
        trainy = simY(2,:);
        testx = simtest(1,:);
        testy = simtest(2,:);
        % testx = out_data(1,:);
        % testy = out_data(2,:);
        %% 绘图
%         figure(1);
%         plot(trainoutdata(1,:),trainoutdata(2,:),'.r',trainx,trainy,'ob');
%         xlabel('/m');ylabel('/m')
%         title('训练结果');
%         figure(2);
%         plot(testoutdata(1,:), testoutdata(2,:),'bo',testx,testy,'r*');
%         for i=1:size(testoutdata,2)
%             hold on;plot([testoutdata(1,i),testx(i)],[testoutdata(2,i),testy(i)],'g-');
%         end
%         xlabel('/m');ylabel('/m')
%         title('测试结果');
        %% 误差分析
        %训练误差
        err = distance(trainoutdata(1,:), trainoutdata(2,:), trainx, trainy);
        err_sum = 0;
        for i = 1 : length(err)
            err_sum = err_sum + err(i);
        end
        err_sum
        err_aver = err_sum / length(err)
        %% 测试误差
        test_err = distance(testoutdata(1,:), testoutdata(2,:), testx, testy);
        err_05m = [];
        err_1m = [];
        err_15m = [];
        err_2m = [];
        err_3m = [];
        testerr_sum = 0;
        for i = 1 : length(test_err)
            testerr_sum = testerr_sum + test_err(i);
            if(test_err(i) < 0.5)
                err_05m = [err_05m, test_err(i)];
            end
            if(test_err(i) < 1)
                err_1m = [err_1m, test_err(i)];
            end
            if(test_err(i) < 2)
                err_2m = [err_2m, test_err(i)];
            end
            if(test_err(i) < 1.5)
                err_15m = [err_15m, test_err(i)];
            end
            if(test_err(i) < 3)
                err_3m = [err_3m, test_err(i)];
            end
        end
        testerr_sum
        testerr_aver = testerr_sum / length(test_err)
        disp('小于0.5m概率：')
        disp(length(err_05m)/length(test_err));
        disp('小于1m概率：')
        disp(length(err_1m)/length(test_err));
        disp('小于1.5m概率：')
        disp(length(err_15m)/length(test_err));
        disp('小于2m概率：')
        disp(length(err_2m)/length(test_err));
        disp('小于3m概率：')
        disp(length(err_3m)/length(test_err));
        %% 循环迭代,寻找最优goal, spread
        res_goal = [res_goal; goal];
        res_spread = [res_spread; spread];
        res_err = [res_err; testerr_aver];
        res_05err = [res_05err; length(err_05m)/length(test_err)];
        res_1err = [res_1err; length(err_1m)/length(test_err)];
        res_2err = [res_2err; length(err_2m)/length(test_err)];
        res_3err = [res_3err; length(err_3m)/length(test_err)];
        
    end
end
