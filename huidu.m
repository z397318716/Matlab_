function D = huidu(left,right,str1,str2)
D = [];
% str1 = 'G:\2020_math_model_code\picture\'
% str2 = '.jpg'
for i3 = left :1: right
   if i3 == 341 || i3 == 947
       continue
   else
       imageName=strcat(str1,num2str(i3),str2);
       i=imread(imageName); %载入真彩色图像
       i=rgb2gray(i); %转换为灰度图
       i=double(i);  %将uint8型转换为double型，否则不能计算统计量
       % sq1=var(i,0,1); %列向量方差，第二个参数为0，表示方差公式分子下面是n-1,如果为1则是n
       % sq2=var(i,0,2); %行向量方差
       avg=mean2(i);  %求图像均值
       [m,n]=size(i);
       s=0;
       for x=1:m
           for y=1:n
               s=s+(i(x,y)-avg)^2; %求得所有像素与均值的平方和。
           end
       end
       B=sqrt(s/(m*n));
       D=[D,B];  %灰度均方值
   end
end