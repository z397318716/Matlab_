function tidudata = tidu(left,right,str1, str2)

tidudata=[];

for k=left :1: right
    if(k==341||k==947)
        continue;
    else
        imageName=strcat(str1,num2str(k),str2);
        i=imread(imageName); %载入真彩色图像
        i=rgb2gray(i); %转换为灰度图
        i=double(i);  %将uint8型转换为double型，否则不能计算统计量
        % sq1=var(i,0,1); %列向量方差，第二个参数为0，表示方差公式分子下面是n-1,如果为1则是n
        % sq2=var(i,0,2); %行向量方差
        avg=mean2(i);  %求图像均值
        [m,n]=size(i);
        s=0;
        for x=1:m-1
            for y=1:n-1
                s=s+sqrt(((i(x,y)-i(x+1,y))^2+(i(x,y)-i(x,y+1))^2)/2);

            end
        end
        tidudata=[tidudata,s];
    end   
end
end
