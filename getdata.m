function[x_train,y_train,x_test,y_test]=getdata()
%°ÑÍ¼Æ¬±ä³ÉÏñËØ¾ØÕó
%path :Í¼Æ¬Â·¾¶ 
% x_train:ÑµÁ·Ñù±¾ÏñËØ¾ØÕó(784,4000)
%y_train:ÑµÁ·Ñù±¾±êÇ©(10,4000)
%x_test:²âÊÔÑù±¾ÏñËØ¾ØÕó(784,1000)
%y_test:²âÊÔÑù±¾±êÇ©(10,1000)


% photopath = './photo/';
% snames=dir([photopath  '*' '.jpg'])%get all filenames in photopath
% l = length(snames)
% 
% %get x_ data
% x_train = [];
% x_test = [];
% 
% for i=1:4000
%     iname=[photopath snames(i).name] %the path of jpg
%     x = imread(iname);  % the shape of x is (28,28)
%     x = reshape(x,784,1);  %reshape x to (784,1)
%     x_train = [x_train,x];
% end
% 
% for k=4001:5000
%     kname=[photopath snames(k).name];  %the path of jpg
%     x = imread(kname);   %the shape of x is (28,28)
%     x = reshape(x,784,1);  %reshape x  to (784,1)
%     x_test = [x_test,x];
% end

x_train=[];

for i=1:1000
      x=im2double(imread(strcat('G:\2020_math_model_code\picture\',num2str(i),'.jpg')));
      %x=reshape(x,784,1);
      x_train=[x_train,x];
end
x_test =[];

for k=1001:1862
      x=im2double(imread(strcat(num2str(k),'.jpg')));
      %x=reshape(x,784,1);
      x_test=[x_test,x];
end
%data=xlsread('label.xlsx');
% y_train=data(:,1:4000);
% y_test = data(:,4001:5000);
[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,Visibility] = readdata();
y_train = class2label(Visibility(1:1000));
y_train = y_train';

x_train;
y_train;
x_test;
y_test;

end
