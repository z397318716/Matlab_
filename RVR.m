[num1] = xlsread('PTU_R06_12.xlsx', 1, 'D3:Q1442' );    %���ݷ�Χ: D3-Q1442
[num2] = xlsread('VIS_R06_12.xlsx', 1, 'D3:Z5756' );    %���ݷ�Χ: D3-Z5757
[num3] = xlsread('WIND_R06_12.xlsx', 1, 'D3:W5757' );    %���ݷ�Χ: D3-W5757

% ֻ�ظ�3�ε�����λ�� 87(1:26) 481(8:00) 637(10:36) 742(12:21) 1399(23:18)
[num11] = xlsread('PTU_R06_15.xlsx', 1, 'D3:Q1442' );    %���ݷ�Χ: D3-Q1442
[num22] = xlsread('VIS_R06_15.xlsx', 1, 'D3:Z5756' );    %���ݷ�Χ: D3-Z5757
[num33] = xlsread('WIND_R06_15.xlsx', 1, 'D3:W5757' );    %���ݷ�Χ: D3-W5757

% PTU----ÿ���Ӳɼ�1һ��, ��1440������    75(1:12) 3�� 608(10:05) 3��  812(13:29) 3��  1062(17:39) 3�� 1214(20:11) ����
% ���������ݶ���1��ɼ�4��,������Ҫ��PTU���е����ݽ�������,ÿ�������ظ�4��
x1_1 = (num1(:,1))';  % PAINS��HPA��   ��վ��ѹ
x2_2 = (num1(:,2))';  % QNH 			������ƽ����ѹ
x3_3 = (num1(:,4))';  % QFE R06  		�ɻ���½������ߵ���ѹ
x4_4 = (num1(:,11))'; % TEMP 			�¶�
x5_5 = (num1(:,12))'; % RH				���ʪ��
x6_6 = (num1(:,13))';    %DEWPOINT		¶���¶�

x1 = [];
x2 = [];
x3 = [];
x4 = [];
x5 = [];
x6 = [];
% VIS
x7 = (num2(:,2))';  % RVR_1A 		1����ƽ��RVRֵ
x8 = (num2(:,10))';  % MOR_1A 		1����ƽ��MORֵ
x9 = (num2(:,21))';  % LIGHT_S		�ƹ�����
x7 = [x7, 125];
x8 = [x8, 50];
x9 = [x9, 10];
% 
x10 = (num3(:,3))';  % WS2A 		2����ƽ������
x11 = (num3(:,11))';  % WD2A		2����ƽ������
x12 = (num3(:,20))';  % CW2A		2����ƽ����ֱ����
for i = 1:length(x1_1)
    if(i == 73 || i == 606 || i == 810 || i == 1060 || i == 1212)
        for i = 1: 3
            x1 = [x1,x1_1(i)];
            x2 = [x2,x2_2(i)];
            x3 = [x3,x3_3(i)];
            x4 = [x4,x4_4(i)];
            x5 = [x5,x5_5(i)];
            x6 = [x6,x6_6(i)];
        end
    else
        for i = 1: 4
            x1 = [x1,x1_1(i)];
            x2 = [x2,x2_2(i)];
            x3 = [x3,x3_3(i)];
            x4 = [x4,x4_4(i)];
            x5 = [x5,x5_5(i)];
            x6 = [x6,x6_6(i)];
        end
    end
end

d1_1 = (num11(:,1))';  % PAINS��HPA��   ��վ��ѹ
d2_2 = (num11(:,2))';  % QNH 			������ƽ����ѹ
d3_3 = (num11(:,4))';  % QFE R06  		�ɻ���½������ߵ���ѹ
d4_4 = (num11(:,11))'; % TEMP 			�¶�
d5_5 = (num11(:,12))'; % RH				���ʪ��
d6_6 = (num11(:,13))';    %DEWPOINT		¶���¶�
d1 = [];
d2 = [];
d3 = [];
d4 = [];
d5 = [];
d6 = [];

d7 = (num22(:,2))';  % RVR_1A 		1����ƽ��RVRֵ
d8 = (num22(:,10))';  % MOR_1A 		1����ƽ��MORֵ
d9 = (num22(:,21))';  % LIGHT_S		�ƹ�����
d7 = [d7, 200];
d8 = [d8, 50];
d9 = [d9, 100];
% 
d10 = (num33(:,3))';  % WS2A 		2����ƽ������
d11 = (num33(:,11))';  % WD2A		2����ƽ������
d12 = (num33(:,20))';  % CW2A		2����ƽ����ֱ����
% ֻ�ظ�3�ε�����λ�� 87(1:26) 481(8:00) 637(10:36) 742(12:21) 1399(23:18)
for ii = 1:length(d1_1)
    if( ii== 87 || ii == 481 || ii == 637 || ii == 742 || ii == 1399)
        for ii = 1: 3
            d1 = [d1,d1_1(ii)];
            d2 = [d2,d2_2(ii)];
            d3 = [d3,d3_3(ii)];
            d4 = [d4,d4_4(ii)];
            d5 = [d5,d5_5(ii)];
            d6 = [d6,d6_6(ii)];
        end
    else
        for ii = 1: 4
            d1 = [d1,d1_1(ii)];
            d2 = [d2,d2_2(ii)];
            d3 = [d3,d3_3(ii)];
            d4 = [d4,d4_4(ii)];
            d5 = [d5,d5_5(ii)];
            d6 = [d6,d6_6(ii)];
        end
    end
end

x1 = [x1, d1];
x2 = [x2, d2];
x3 = [x3, d3];
x4 = [x4, d4];
x5 = [x5, d5];
x6 = [x6, d6];
x7 = [x7, d7];
x8 = [x8, d8];
x9 = [x9, d9];
x10 = [x10, d10];
x11 = [x11, d11];
x12 = [x12, d12];

input_train = [x1; x2; x3; x4; x5; x6; x9; x10; x11; x12];  %��������
%output_train = [x7; x8];  % �������
output_train = x7;  % �������
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
for j = 1:10
    NodeNum1 = 8; % �����һ��ڵ���
    NodeNum2 = 5;   % ����ڶ���ڵ���
    TypeNum = 1;   % ���ά��
    % ʹ������,�����������-----
    % �������� 12  �����������Ϊ 7 ��������Ϊ 2
    net=newff(minmax(inputData),[NodeNum2,TypeNum],{TF2 TF3},'traingdx');%���紴��
    %net=newff(minmax(inputData),[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'traingdx');%���紴��
    %net = newff(minmax(inputData),[9,2],{TF1 TF2},'traingdm');%���紴��
    %net = newff(inputData, outputData, 8, {'tansig', 'purelin'}, 'trainbr');
    %net = fitnet(inputData, outputData, 9, {'tansig', 'purelin'}, 'trainlm');
    % ��������
    net.trainparam.goal = 1e-6; %ѵ��Ŀ�꣺����������
    net.trainparam.show = 8;    %ÿѵ��400��չʾһ�ν��
    net.trainparam.epochs = 15000;  %���ѵ��������15000
    net.trainParam.lr = 0.005;  %ѧϰ��,Ӧ����Ϊ����ֵ��̫����Ȼ���ڿ�ʼ�ӿ������ٶȣ����ٽ���ѵ�ʱ�����������������ʹ�޷�����
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
    % net.trainFcn = 'trainrp'; % RPROP(����BP)�㷨,�ڴ�������С
    %
    % (�����ݶ��㷨)
    % net.trainFcn = 'traincgf'; % Fletcher-Reeves�����㷨
    % net.trainFcn = 'traincgp'; % Polak-Ribiere�����㷨,�ڴ������Fletcher-Reeves�����㷨�Դ�
    % net.trainFcn = 'traincgb'; % Powell-Beal��λ�㷨,�ڴ������Polak-Ribiere�����㷨�Դ�
    %
    % (�����������ѡ�㷨)
    %net.trainFcn = 'trainscg'; % Scaled Conjugate Gradient�㷨,�ڴ�������Fletcher-Reeves�����㷨��ͬ,�����������������㷨��С�ܶ�
    % net.trainFcn = 'trainbfg'; % Quasi-Newton Algorithms - BFGS Algorithm,���������ڴ�������ȹ����ݶ��㷨��,�������ȽϿ�
    % net.trainFcn = 'trainoss'; % One Step Secant Algorithm,���������ڴ��������BFGS�㷨С,�ȹ����ݶ��㷨�Դ�
    %
    % (�����������ѡ�㷨)
    %net.trainFcn = 'trainlm'; % Levenberg-Marquardt�㷨,�ڴ��������,�����ٶ����
    % net.trainFcn = 'trainbr'; % ��Ҷ˹�����㷨
    %
    % �д����Ե������㷨Ϊ:'traingdx','trainrp','trainscg','trainoss', 'trainlm'
    
    net.trainFcn = 'traingda'; % ��ѧϰ���ݶ��½��㷨
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
    absTrainError = trainOutput-trainInsect;
    absTestError = testOutput-testInsect;
    error_sum = sqrt(absTestError(1).^2+absTestError(2).^2+absTestError(3).^2);
    %All_error = [];
    All_error = [All_error, error_sum];
    eps=90;%��Ϊ3��������ݵı�׼�����ÿ������ƫ����һ����Χ�ڶ��б�
    if ((abs(absTestError(1))<=30 )&&(abs(absTestError(2))<=30)&&(abs(absTestError(3))<=30)||(error_sum<=eps))
        save mynetdata net
        break
    end
    j
end
j
%Min_error_sqrt = min(All_error)

testOutput
testInsect

%---------------------------------------------------
% ���ݷ����ͻ�ͼ
%---------------------------------------------------  
figure
t = 1:length(trainOutput);
k = 1:length(validateOutput);
subplot(2,1,1);
plot(t,trainOutput,t,trainInsect);
legend('��ʵ����Ԥ����','��ʵ����');
subplot(2,1,2);
plot(k,validateInsect,'g--',k,validateOutput,'b-',k,testInsect,'ro' ,k,testOutput,'m*');
legend('�仯����ԭʼֵ','�仯����BPԤ��ֵ','��������ԭʼֵ','��������BPԤ��ֵ');

ylabel('�ܼ���MOR');

figure
xx=1:length(All_error);
plot(xx,All_error)
title('���仯ͼ')
w12 = net.iw{1,1} %��1�㣨����㣩����2�㣨���㣩��Ȩֵ
b2 = net.b{1}    %��2�㣨���㣩����ֵ

w23 = net.lw{2,1} %��2�㣨����㣩����3�㣨����㣩��Ȩֵ
b3 = net.b{2}    %��3�㣨����㣩����ֵ


% figure;  %�½���ͼ���ڴ���
% t=1:length(simout);
% 
% %��ͼ���Ա�ԭ�����ܼ������ݺ�����Ԥ����ܼ���
% %subplot(2,1,1);
% plot(t,outputData, 'r',t, simout,'b');title('1����ƽ��MORֵ');
% legend('ԭʼ����','�������');
% %plot(t,x7, 'r')
% % subplot(2,1,2);plot(t,outputData(2,:), 'r',t, simout(2,:),'b');title('1����ƽ��MORֵ');
% %plot(t,x8, 'b')
% 
% %subplot(2,2,3);plot(t, simout(1,:),'b');title('�������_1����ƽ��RVRֵ');
% %subplot(2,2,4);plot(t, simout(2,:),'b');title('�������_1����ƽ��MORֵ');
% %subplot(2,2,3)
% %plot(t,x7, 'r',t,simout,'b')