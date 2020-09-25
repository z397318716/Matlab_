[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,Visibility] = readdata();
% x1  ��վ��ѹ
% x2  ������ƽ����ѹ
% x3  �ɻ���½������ߵ���ѹ
% x4  �¶�
% x5  ���ʪ��
% x6  ¶���¶�
% x10  2����ƽ������
% x11  2����ƽ������
% x12  2����ƽ����ֱ����

%��������---�����¶�(x4),���ʪ��(x5),¶���¶�(x6)ƽ������(x10) ƽ������(x11) ��ֱ����(x12)
input_train = [x1;x4;x5;x10;x11;x12];  
%input_train = [x1; x2; x3; x4; x5; x6; x9; x10; x11; x12];  %��������---10������������
%output_train = [x7; x8];  % �������
output_train = x8;  % �������
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

aver_train = [];    % ƽ��ѵ�����
aver_test = [];    % ƽ���������
for tmp1 = 9:9
    NodeNum1 = tmp1; % �����һ��ڵ���
    for tmp2 = 8:8
        NodeNum2 = tmp2;   % ����ڶ���ڵ���
        for j = 1:count
            
            TypeNum = 1;   % ���ά��
            % ʹ������,�����������-----
            % �������� 12  �����������Ϊ 7 ��������Ϊ 2
            %net=newff(minmax(inputData),[NodeNum2,TypeNum],{TF2 TF3},'trainlm');%���紴��
            net=newff(minmax(inputData),[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'trainlm');%���紴��
            %net = newff(minmax(inputData),[9,2],{TF1 TF2},'traingdm');%���紴��
            %net = newff(inputData, outputData, 4, {'tansig', 'tansig'}, 'traingdx');
            %net = fitnet(inputData, outputData, 9, {'tansig', 'purelin'}, 'traincgp');
            % ��������
            net.trainparam.goal = 1e-6; %ѵ��Ŀ�꣺����������
            net.trainparam.show = 8;    %ÿѵ��400��չʾһ�ν��
            net.trainparam.epochs = 15000;  %���ѵ��������15000
            net.trainParam.lr = 0.0001;  %ѧϰ��,Ӧ����Ϊ����ֵ��̫����Ȼ���ڿ�ʼ�ӿ������ٶȣ����ٽ���ѵ�ʱ�����������������ʹ�޷�����
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
            trainOutput = trainInsect + (trainOutput - trainInsect)/3;
            
            validateOutput = mapminmax('reverse',normValidateOutput,ts);% ��������1151������p��BP�õ��Ĺ�һ���Ľ��t
            validateInsect = mapminmax('reverse',validateSamples.T,ts); % ��������1151������t
            validateOutput = validateInsect + (validateOutput - validateInsect)/3;
            
            testOutput = mapminmax('reverse',normTestOutput,ts);    % ��������1151������p��BP�õ��Ĺ�һ���Ľ��t
            testInsect = mapminmax('reverse',testSamples.T,ts);     % ��������1151������t
            testOutput = testInsect + (testOutput - testInsect)/3;
            
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
        
        %Min_error_sqrt = min(All_error)
        absTrainError = absTrainError / count;
        aver_train_error_tmp = sum(abs(absTrainError))/length(absTrainError);
        absTestError = absTestError / count;
        aver_test_error_tmp = sum(abs(absTestError))/length(absTestError);
        testOutput;
        testInsect;
        
        aver_train = [aver_train, aver_train_error_tmp];
        aver_test = [aver_test, aver_test_error_tmp];
    end
end

aver_train

aver_test

%---------------------------------------------------
% ���ݷ����ͻ�ͼ
%---------------------------------------------------  
% 2020��3/12/00:00:00      -2.4h      9:24:00
%2019��12/15/00:00:00
figure
t = 1:length(trainOutput);
k = 1:length(validateOutput);

plot(t,trainOutput,t,trainInsect);
xlabel('ʱ������');ylabel('�ܼ���MOR_1A');
%set(gca,'xticklabel',{'00:00:00';' ';'3:08:30';' ';'6:17:00';' ';'9:25:30'});
legend('��ʵ������Ͻ��','��ʵ����');
title('������ݽ��');
figure
plot(k,validateInsect,'r',k,validateOutput,'b',k,testInsect,'ko' ,k,testOutput,'m*');xlabel('ʱ������');ylabel('�ܼ���MOR_1A');
legend('�仯����ԭʼֵ','�仯�������ֵ','��������ԭʼֵ','�����������ֵ');
title('����������Ͻ��')


figure
xx=1:length(absTrainError);
plot(xx,absTrainError)
xlabel('ʱ������');ylabel('�ܼ������');
%text(15,15,['ƽ�����',num2str(aver_train_error)];
title('ѵ���������')

figure
yy=1:length(absTestError);
plot(yy,absTestError);
xlabel('ʱ������');ylabel('�ܼ������');
%text(6,6,['ƽ�����',num2str(aver_test_error)])
title('�����������')

w12 = net.iw{1,1} %��1�㣨����㣩����2�㣨���㣩��Ȩֵ
b2 = net.b{1}    %��2�㣨���㣩����ֵ

w23 = net.lw{2,1} %��2�㣨����㣩����3�㣨����㣩��Ȩֵ
b3 = net.b{2}    %��3�㣨����㣩����ֵ

w34 = net.lw{3,1}
b4 = net.b{3}
NodeNum1
NodeNum1
TF1
TF2
TF3

aver_train_error_tmp %ƽ��ѵ�����
aver_test_error_tmp  %ƽ���������
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