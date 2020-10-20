clc;
clear;
%% 读数据
[x1,x2,x3,x4,train_x,train_y,t1,t2,t3,t4,test_x,test_y] = read_light_data();
train_indata  = [x1'; x2'; x3'; x4'];
train_outdata  = [train_x'; train_y'];
test_indata = [t1'; t2'; t3'; t4'];
test_outdata = [test_x'; test_y'];

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
for goal = 0.012:0.001:0.012
    for spread = 8:1:8
        net = newrb(train_indata, train_outdata, goal, spread);    %以X，Y建立径向基网络，目标误差为0.01，径向基的spread=2
        simY = sim(net, train_indata);        %用建好的网络拟合原始数据
        % 用训练好的网络训练数据
        simtest = sim(net, test_indata);
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
%         plot(train_outdata(1,:),train_outdata(2,:),'.r',trainx,trainy,'ob');
%         xlabel('/m');ylabel('/m')
%         title('训练结果');
%         figure(2);
%         plot(test_outdata(1,:), test_outdata(2,:),'bo',testx,testy,'r*');
%         for i=1:size(test_outdata,2)
%             hold on;plot([test_outdata(1,i),testx(i)],[test_outdata(2,i),testy(i)],'g-');
%         end
%         xlabel('/m');ylabel('/m')
%         title('测试结果');
        %% 误差分析
        %训练误差
        err = distance(train_outdata(1,:), train_outdata(2,:), trainx, trainy);
        err_sum = 0;
        for i = 1 : length(err)
            err_sum = err_sum + err(i);
        end
        err_sum
        err_aver = err_sum / length(err)
        %% 测试误差
        test_err = distance(test_outdata(1,:), test_outdata(2,:), testx, testy);
        err_003m = [];
        err_005m = [];
        err_01m = [];
        err_02m = [];
        testerr_sum = 0;
        for i = 1 : length(test_err)
            testerr_sum = testerr_sum + test_err(i);
            if(test_err(i) < 0.03)
                err_003m = [err_003m, test_err(i)];
            end
            if(test_err(i) < 0.05)
                err_005m = [err_005m, test_err(i)];
            end
            if(test_err(i) < 0.1)
                err_01m = [err_01m, test_err(i)];
            end
            if(test_err(i) < 0.2)
                err_02m = [err_02m, test_err(i)];
            end
        end
        testerr_sum
        testerr_aver = testerr_sum / length(test_err)
        disp('小于0.03m概率：')
        disp(length(err_003m)/length(test_err));
        disp('小于0.05m概率：')
        disp(length(err_005m)/length(test_err));
        disp('小于0.1m概率：')
        disp(length(err_01m)/length(test_err));
        disp('小于0.2m概率：')
        disp(length(err_02m)/length(test_err));
        %% 循环迭代,寻找最优goal, spread
        res_goal = [res_goal, goal];
        res_spread = [res_spread, spread];
        res_err = [res_err, testerr_aver];
        res_05err = [res_05err,length(err_003m)/length(test_err)];
        res_1err = [res_1err, length(err_005m)/length(test_err)];
        res_2err = [res_2err, length(err_01m)/length(test_err)];
        res_3err = [res_3err, length(err_02m)/length(test_err)];
    end
end