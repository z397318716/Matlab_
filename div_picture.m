VideoAd = VideoReader('G:\2020数学建模\2020年中国研究生数学建模竞赛赛题\2020年中国研究生数学建模竞赛赛题\2020年E题\机场视频2\Fog20200313000026.mp4');
numFrames = VideoAd.NumberOfFrames;% 帧的总数
%numFrames = VideoAd.CurrentTime;% 帧的总数  在高版本MATLAB中, NumberOfFrames被取消,
videoF=VideoAd.FrameRate;%FrameRate 视频采集速率
videoD=VideoAd.Duration;  %Duration  时间
numname=1;%the length of image name
nz = strcat('%0',num2str(numname),'d');

T=15*videoF;%提取帧数间隔，这里设定每15秒提取一帧
% 该视频是 25帧/s;
i=1;
 for k = 1 :T: numFrames%     
     numframe = read(VideoAd,k);%读取第几帧
     num=sprintf(nz,i);   %i为保存图片的序号
     i=i+1;
     imwrite(numframe,strcat('G:\2020_math_model_code\picture\',num,'.jpg'),'jpg');  
     % 保存帧,
     %位置：F:\PeopleTrainingTest_2018.7.25\Test_divide\
 end
 
numframe = read(VideoAd,470);%读取第4帧
num=sprintf(nz,9000);   %i为保存图片的序号
%i=i+1;
imwrite(numframe,strcat('G:\2020_math_model_code\picture\',num,'.jpg'),'jpg');