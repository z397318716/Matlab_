function tidudata = tidu(left,right,str1, str2)

tidudata=[];

for k=left :1: right
    if(k==341||k==947)
        continue;
    else
        imageName=strcat(str1,num2str(k),str2);
        i=imread(imageName); %�������ɫͼ��
        i=rgb2gray(i); %ת��Ϊ�Ҷ�ͼ
        i=double(i);  %��uint8��ת��Ϊdouble�ͣ������ܼ���ͳ����
        % sq1=var(i,0,1); %����������ڶ�������Ϊ0����ʾ���ʽ����������n-1,���Ϊ1����n
        % sq2=var(i,0,2); %����������
        avg=mean2(i);  %��ͼ���ֵ
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
