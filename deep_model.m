readdata();     % ������
str1 = 'G:\2020_math_model_code\picture\';
str2 = '.jpg';
D = huidu(1, 1862, str1, str2);    % �ҶȾ���������
T = tidu(1, 1862, str1, str2);     % �ݶ�����

input_train = [D;T];  
%input_train = [x1; x2; x3; x4; x5; x6; x9; x10; x11; x12];  %��������---10������������
%output_train = [x7; x8];  % �������
output_train = Visibility;  % �������
%outputData = x7;

% ��һ������,����mapminmax(x,ymin,ymax)������ʹ��ֵ��һ����[ymin,ymax]֮�� Ĭ��[-1, 1]
% ps�������ã�ps��Ҫ�ڽ������һ������Ҫ���ã�����ʹ��ͬ����settings��һ������һ������
[inputData,ps]=mapminmax(input_train);
[outputData,ts]=mapminmax(output_train);

%---------------------------------------------------
%�������򣬼����ദ��
%�������5755�����ݵ�20%����1151�飬������Ϊ�������ݣ�
% ������20%����1151�飬������Ϊ�仯���ݣ�
%����3453�������������룬����ѵ����
%dividevec()�������������ȡ�������ַ�������ݣ�ԭ����˳�򱻴���
%�������õ��﷨
%[trainV,valV,testV] = dividevec(p,t,valPercent,testPercent)
%����pΪ�������ݣ�tΪ�������
%valPercentΪѵ���õı仯�������������еİٷֱ�
%testPercentΪѵ���õĲ����������������еİٷֱ�
%���trainV,valV,testV�ֱ�Ϊ��������Ӧ�ٷֱȣ���ȡ�õ�������
%���⣬���Һ�����ݣ�p��t���Ƕ�Ӧ��
%---------------------------------------------------
testPercent = 0.10;  % Adjust as desired
validatePercent = 0.10;  % Adust as desired
[trainSamples,validateSamples,testSamples] = dividevec(inputData,outputData,validatePercent,testPercent);
TF1 = 'tansig';TF2 = 'tansig'; TF3 = 'tansig';%���㴫�亯����TF3Ϊ����㴫�亯��
%���ഫ�亯��
%TF1 = 'tansig';TF2 = 'logsig';
%TF1 = 'logsig';TF2 = 'purelin';
%TF1 = 'tansig';TF2 = 'tansig';
%TF1 = 'logsig';TF2 = 'logsig';
%TF1 = 'purelin';TF2 = 'purelin';
All_error = [];
absTrainError = [];
absTestError = [];
count = 10;
for j = 1:count
    NodeNum1 = 7; % �����һ��ڵ���
    NodeNum2 = 7;   % ����ڶ���ڵ���
    TypeNum = 1;   % ���ά��
    % ʹ������,�����������-----
    % �������� 12  �����������Ϊ 7 ��������Ϊ 2
    %net=newff(minmax(inputData),[NodeNum2,TypeNum],{TF2 TF3},'trainlm');%���紴��
    net=newff(minmax(inputData),[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'traingdx');%���紴��
    %net = newff(minmax(inputData),[9,2],{TF1 TF2},'traingdm');%���紴��
    %net = newff(inputData, outputData, 4, {'tansig', 'tansig'}, 'traingdx');
    %net = fitnet(inputData, outputData, 9, {'tansig', 'purelin'}, 'traincgp');
    % ��������
    net.trainparam.goal = 1e-6; %ѵ��Ŀ�꣺����������
    net.trainparam.show = 8;    %ÿѵ��400��չʾһ�ν��
    net.trainparam.epochs = 15000;  %���ѵ��������15000
    net.trainParam.lr = 0.001;  %ѧϰ��,Ӧ����Ϊ����ֵ��̫����Ȼ���ڿ�ʼ�ӿ������ٶȣ����ٽ���ѵ�ʱ�����������������ʹ�޷�����
    %net.divideFcn = '';
    
    %---------------------------------------------------
    % ָ��ѵ������
    %---------------------------------------------------
    % net.trainFcn = 'traingd'; % �ݶ��½��㷨
    % net.trainFcn = 'traingdm'; % �����ݶ��½��㷨
    %
    % net.trainFcn = 'traingda'; % ��ѧϰ���ݶ��½��㷨
    % net.trainFcn = 'traingdx'; % ��ѧϰ�ʶ����ݶ��½��㷨
    %
    % (�����������ѡ�㷨)
    %net.trainFcn = 'trainrp'; % RPROP(����BP)�㷨,�ڴ�������С
    %
    % (�����ݶ��㷨)
    % net.trainFcn = 'traincgf'; % Fletcher-Reeves�����㷨
    % net.trainFcn = 'traincgp'; % Polak-Ribiere�����㷨,�ڴ������Fletcher-Reeves�����㷨�Դ�
    % net.trainFcn = 'traincgb'; % Powell-Beal��λ�㷨,�ڴ������Polak-Ribiere�����㷨�Դ�
    %
    % (�����������ѡ�㷨)
    % net.trainFcn = 'trainscg'; % Scaled Conjugate Gradient�㷨,�ڴ�������Fletcher-Reeves�����㷨��ͬ,�����������������㷨��С�ܶ�
    % net.trainFcn = 'trainbfg'; % Quasi-Newton Algorithms - BFGS Algorithm,���������ڴ�������ȹ����ݶ��㷨��,�������ȽϿ�
    % net.trainFcn = 'trainoss'; % One Step Secant Algorithm,���������ڴ��������BFGS�㷨С,�ȹ����ݶ��㷨�Դ�
    %
    % (�����������ѡ�㷨)
    net.trainFcn = 'trainlm'; % Levenberg-Marquardt�㷨,�ڴ��������,�����ٶ����
    % net.trainFcn = 'trainbr'; % ��Ҷ˹�����㷨
    %
    % �д����Ե������㷨Ϊ:'traingdx','trainrp','trainscg','trainoss', 'trainlm'
    
    %net.trainFcn = 'traingda'; % ��ѧϰ���ݶ��½��㷨
    %net.trainfcn='trainlm';
    [net,tr] = train(net,trainSamples.P,trainSamples.T,[],[],validateSamples,testSamples);
    %[net,tr] = train(net,inputData,outputData);%����matlab�����繤�����Դ���train����ѵ������
    
    %����matlab�����繤�����Դ���sim�����õ������Ԥ��ֵ
    %simout = sim(net,inputData);
    %���������3453��p���ݣ�BP�õ��Ľ��t
    %[normTrainOutput,Pf,Af,E,trainPerf] = sim(net,trainSamples.P,[],[],trainSamples.T);
    [normTrainOutput,trainPerf] = sim(net,trainSamples.P,[],[],trainSamples.T);
    %��������1151������p��BP�õ��Ľ��t
    [normValidateOutput,validatePerf] = sim(net,validateSamples.P,[],[],validateSamples.T);
    %[normValidateOutput,Pf,Af,E,validatePerf] = sim(net,validateSamples.P,[],[],validateSamples.T);
    %�������Ե�1151������p��BP�õ��Ľ��t
    [normTestOutput,testPerf] = sim(net,testSamples.P,[],[],testSamples.T);
    %[normTestOutput,Pf,Af,E,testPerf] = sim(net,testSamples.P,[],[],testSamples.T);
    
    %---------------------------------------------------
    % ����������ݷ���һ���������ҪԤ�⣬ֻ�轫Ԥ�������P����
    % �����Ԥ����t
    %---------------------------------------------------
    trainOutput = mapminmax('reverse',normTrainOutput,ts);  % ���������3453��p���ݣ�BP�õ��ķ���һ����Ľ��t
    trainInsect = mapminmax('reverse',trainSamples.T,ts);   % ���������3453������t
    validateOutput = mapminmax('reverse',normValidateOutput,ts);% ��������1151������p��BP�õ��Ĺ�һ���Ľ��t
    validateInsect = mapminmax('reverse',validateSamples.T,ts); % ��������1151������t
    testOutput = mapminmax('reverse',normTestOutput,ts);    % ��������1151������p��BP�õ��Ĺ�һ���Ľ��t
    testInsect = mapminmax('reverse',testSamples.T,ts);     % ��������1151������t
    
    %����������
    if j == 1
        absTrainError = trainOutput - trainInsect;
        absTestError = testOutput - testInsect;
    else
        absTrainError =absTrainError + (trainOutput - trainInsect);    % ѵ���������
        absTestError = absTestError + (testOutput - testInsect);       % �������ݵ��������
    end
%     %error_sum = sqrt(absTestError(1).^2+absTestError(2).^2+absTestError(3).^2);
%     %All_error = [];
%     All_error = [All_error, error_sum];
%     eps=90;%��Ϊ3��������ݵı�׼�����ÿ������ƫ����һ����Χ�ڶ��б�
%     if ((abs(absTestError(1))<=30 )&&(abs(absTestError(2))<=30)&&(abs(absTestError(3))<=30)||(error_sum<=eps))
%         save mynetdata net
%         break
%     end
    j
end
j
%Min_error_sqrt = min(All_error)
absTrainError = absTrainError / count;
aver_train_error = sum(abs(absTrainError))/length(absTrainError);
absTestError = absTestError / count;
aver_test_error = sum(abs(absTestError))/length(absTestError);
testOutput;
testInsect;

%����ѵ���õ������ڵ�ǰ����Ŀ¼�µ�deep_model �ļ��У�netΪ������
save('deep_model', 'net');
save('set', 'ts','ps');


%---------------------------------------------------
% ���ݷ����ͻ�ͼ
%---------------------------------------------------  
figure
t = 1:length(trainOutput);
k = 1:length(validateOutput);
%subplot(2,1,1);
plot(t,trainOutput,t,trainInsect);
xlabel('ʱ������');ylabel('�ܼ���MOR_1A');
legend('Ԥ��ֵ','ʵ��ֵ');
%subplot(2,1,2);
figure
%plot(k,validateInsect,'g--',k,validateOutput,'b-',k,testInsect,'ro' ,k,testOutput,'m*');
plot(k,testInsect,'ro' ,k,testOutput,'m*');
%legend('�仯����ԭʼֵ','�仯����BPԤ��ֵ','��������ԭʼֵ','��������BPԤ��ֵ');
legend('��������ʵ��ֵ','��������Ԥ��ֵ');
xlabel('ʱ������');ylabel('�ܼ���MOR_1A');

figure
xx=1:length(absTrainError);

plot(xx,absTrainError);
xlabel('ʱ������');ylabel('�ܼ���MOR_1A');
%text(15,15,['ƽ�����',num2str(aver_train_error)])
title('ѵ���������');
figure
yy=1:length(absTestError);
plot(yy,absTestError);
xlabel('ʱ������');ylabel('�ܼ���MOR_1A');
%text(6,6,['ƽ�����',num2str(aver_test_error)])
title('�����������');

aver_train_error %ƽ��ѵ�����
aver_test_error  %ƽ���������

% D=[];
% N = 
% % 2774��ͼƬ(ÿ��15��ɼ�һ��)
% % ��Ƶ��ʼʱ�� 00:00:26  ��Ӧ VIS_R06_12 3842������ 2020/3/13  0:00:30
% for k=1:1:466
%     imageName=strcat(num2str(k),'.jpg');
%     i=imread(imageName); %�������ɫͼ��
%     i=rgb2gray(i); %ת��Ϊ�Ҷ�ͼ
%     i=double(i);  %��uint8��ת��Ϊdouble�ͣ������ܼ���ͳ����
%     % sq1=var(i,0,1); %����������ڶ�������Ϊ0����ʾ���ʽ����������n-1,���Ϊ1����n
%     % sq2=var(i,0,2); %����������
%     avg=mean2(i);  %��ͼ���ֵ
%     [m,n]=size(i);
%     s=0;
%     for x=1:m
%         for y=1:n
%             s=s+(i(x,y)-avg)^2; %��������������ֵ��ƽ���͡�
%         end
%     end
%     B=sqrt(s/(m*n));
%     D=[D,B];  %�ҶȾ���ֵ
%     
% end
% t=1:466;
% % plot(t,D,'r');
% % [inputdata,intputs]=mapminmax(D);%��һ��
% % plot(t,inputdata,'r');
% 
%  hold on;
% 
% data=[];
% [num1]=xlsread('1.xlsx',1,'D3840:Q5757');
% x11=(num1(:,2));
% for i=1:4:1864
%     data =[data,x11(i)];  %�ܼ���
% end
% plot(t,data,'g');
% % [inputdata,intputs]=mapminmax(data);%��һ��
% % plot(t,inputdata,'g');