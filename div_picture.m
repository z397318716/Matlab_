VideoAd = VideoReader('G:\2020��ѧ��ģ\2020���й��о�����ѧ��ģ��������\2020���й��о�����ѧ��ģ��������\2020��E��\������Ƶ2\Fog20200313000026.mp4');
numFrames = VideoAd.NumberOfFrames;% ֡������
%numFrames = VideoAd.CurrentTime;% ֡������  �ڸ߰汾MATLAB��, NumberOfFrames��ȡ��,
videoF=VideoAd.FrameRate;%FrameRate ��Ƶ�ɼ�����
videoD=VideoAd.Duration;  %Duration  ʱ��
numname=1;%the length of image name
nz = strcat('%0',num2str(numname),'d');

T=15*videoF;%��ȡ֡������������趨ÿ15����ȡһ֡
% ����Ƶ�� 25֡/s;
i=1;
 for k = 1 :T: numFrames%     
     numframe = read(VideoAd,k);%��ȡ�ڼ�֡
     num=sprintf(nz,i);   %iΪ����ͼƬ�����
     i=i+1;
     imwrite(numframe,strcat('G:\2020_math_model_code\picture\',num,'.jpg'),'jpg');  
     % ����֡,
     %λ�ã�F:\PeopleTrainingTest_2018.7.25\Test_divide\
 end
 
numframe = read(VideoAd,470);%��ȡ��4֡
num=sprintf(nz,9000);   %iΪ����ͼƬ�����
%i=i+1;
imwrite(numframe,strcat('G:\2020_math_model_code\picture\',num,'.jpg'),'jpg');