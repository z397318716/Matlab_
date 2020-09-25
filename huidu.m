function D = huidu(left,right,str1,str2)
D = [];
% str1 = 'G:\2020_math_model_code\picture\'
% str2 = '.jpg'
for i3 = left :1: right
   if i3 == 341 || i3 == 947
       continue
   else
       imageName=strcat(str1,num2str(i3),str2);
       i=imread(imageName); %�������ɫͼ��
       i=rgb2gray(i); %ת��Ϊ�Ҷ�ͼ
       i=double(i);  %��uint8��ת��Ϊdouble�ͣ������ܼ���ͳ����
       % sq1=var(i,0,1); %����������ڶ�������Ϊ0����ʾ���ʽ����������n-1,���Ϊ1����n
       % sq2=var(i,0,2); %����������
       avg=mean2(i);  %��ͼ���ֵ
       [m,n]=size(i);
       s=0;
       for x=1:m
           for y=1:n
               s=s+(i(x,y)-avg)^2; %��������������ֵ��ƽ���͡�
           end
       end
       B=sqrt(s/(m*n));
       D=[D,B];  %�ҶȾ���ֵ
   end
end