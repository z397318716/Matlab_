%%调用网络，以函数的形式
function jiazaiwangluo()
%网络加载,注意文件名要加单引号
load('-mat','deep_model'); 
load ('set.mat');

%从指定目录加载“load('-mat','d:\aaa.mat'); ”
% str1 = 'G:\2020_math_model_code\picture\';
% str2 = '.jpg';
str1 = 'G:\2020_math_model_code\pre_picture\original_frame';
str2 = '.bmp';
D = huidu(1, 100, str1, str2);    % 灰度均方差数据
T = tidu(1, 100, str1, str2);     % 梯度数据
% 1863 : 2773


pre_data = [D;T];
% 归一化
[inputData,ps]=mapminmax(pre_data);
%调用matlab神经网络工具箱自带的sim函数得到网络的预测值
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
xlabel('时间序列');ylabel('能见度MOR_1A');
%set(gca,'xticklabel',{'00:00:00';' ';'3:08:30';' ';'6:17:00';' ';'9:25:30'});
legend('真实数据拟合结果','真实数据');
title('拟合数据结果');

figure();
plot(t, process_data);
axis([0 101 0 200])
xlabel('时间序列');ylabel('能见度');
% m=linspace(datenum('6:00','HH:MM'),datenum('12:00','HH:MM'),13); 
% set(gca,'xtick',6:0.5:12); 
% for n=1:length(m) 
%     tm{n}=datestr(m(n),'HH:MM'); 
% end 
% set(gca,'xticklabel',tm);


% 亮度 对比度 梯度 灰度均方误差+文献内容   bp   神经网络 使用 视频数据 及对应的能见度值训练
