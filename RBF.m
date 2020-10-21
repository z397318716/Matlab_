clc;
clear;
%% ������
[x1, x2, x3, x4, x5, x6, x7, x8] = readFingerprint();
outdata  = [x1';x2'];     %ע���м��Ƿֺ�
indata  = [x3'; x4'; x5'; x6'; x7'; x8'];

%% ��ֵ�˲�
% indata_1  = [x3'; x4'; x5'; x6'; x7'; x8'];
% indata = medfilt2(indata_1,[3,3]);   % ��ֵ�˲�
% indata(1,1) = -38;
% indata(6,1) = -68;
% indata(1,1015) = -72;
% indata(6,1015) = -66;

%%
% ȡż����������Ϊѵ��, ��������Ϊ����
% ���k������ȡһ��������Ϊ��������,������Ϊѵ������
% ѵ������:812    ��������: 203
k = 10;
n = 21:k:1015;   % ȡ��������
m = 1:1:1015;   % ȡѵ������
for j = 1:length(indata)
    if(j < 913 && mod(m(j),k) == 1)
       m(j) = []; 
    end
end
traindata = indata(:,m);
trainoutdata = outdata(:,m);
testdata = indata(:,n);
testoutdata = outdata(:,n);
% %% ���ݹ�һ������
% [input, ps] = mapminmax(indata');
% [output, ts] = mapminmax(outdata');
%%
res_goal = [];
res_spread = [];
res_err = [];
res_05err = [];
res_1err = [];
res_2err = [];
res_3err = [];
for goal = 0.76:0.01:0.76
    for spread = 12:1:12
        net = newrb(traindata, trainoutdata, goal, spread);    %��X��Y������������磬Ŀ�����Ϊ0.01���������spread=2
        %net = newrbe(traindata, trainoutdata, 6);
        simY = sim(net, traindata);        %�ý��õ��������ԭʼ����
        % ��ѵ���õ�����ѵ������
        simtest = sim(net, testdata);
        %% ����һ��
        % out_data = mapminmax('reverse',simY,ts);
        % %% �����������Ȩֵ/��ֵ
        % w12 = net.iw{1,1} %��1�㣨����㣩����2�㣨���㣩��Ȩֵ
        % b2 = net.b{1}    %��2�㣨���㣩����ֵ
        %
        % w23 = net.lw{2,1} %��2�㣨����㣩����3�㣨����㣩��Ȩֵ
        % b3 = net.b{2}    %��3�㣨����㣩����ֵ
        
        %t = 1:size(output);
        trainx = simY(1,:);
        trainy = simY(2,:);
        testx = simtest(1,:);
        testy = simtest(2,:);
        % testx = out_data(1,:);
        % testy = out_data(2,:);
        %% ��ͼ
%         figure(1);
%         plot(trainoutdata(1,:),trainoutdata(2,:),'.r',trainx,trainy,'ob');
%         xlabel('/m');ylabel('/m')
%         title('ѵ�����');
%         figure(2);
%         plot(testoutdata(1,:), testoutdata(2,:),'bo',testx,testy,'r*');
%         for i=1:size(testoutdata,2)
%             hold on;plot([testoutdata(1,i),testx(i)],[testoutdata(2,i),testy(i)],'g-');
%         end
%         xlabel('/m');ylabel('/m')
%         title('���Խ��');
        %% ������
        %ѵ�����
        err = distance(trainoutdata(1,:), trainoutdata(2,:), trainx, trainy);
        err_sum = 0;
        for i = 1 : length(err)
            err_sum = err_sum + err(i);
        end
        err_sum
        err_aver = err_sum / length(err)
        %% �������
        test_err = distance(testoutdata(1,:), testoutdata(2,:), testx, testy);
        err_05m = [];
        err_1m = [];
        err_15m = [];
        err_2m = [];
        err_3m = [];
        testerr_sum = 0;
        for i = 1 : length(test_err)
            testerr_sum = testerr_sum + test_err(i);
            if(test_err(i) < 0.5)
                err_05m = [err_05m, test_err(i)];
            end
            if(test_err(i) < 1)
                err_1m = [err_1m, test_err(i)];
            end
            if(test_err(i) < 2)
                err_2m = [err_2m, test_err(i)];
            end
            if(test_err(i) < 1.5)
                err_15m = [err_15m, test_err(i)];
            end
            if(test_err(i) < 3)
                err_3m = [err_3m, test_err(i)];
            end
        end
        testerr_sum
        testerr_aver = testerr_sum / length(test_err)
        disp('С��0.5m���ʣ�')
        disp(length(err_05m)/length(test_err));
        disp('С��1m���ʣ�')
        disp(length(err_1m)/length(test_err));
        disp('С��1.5m���ʣ�')
        disp(length(err_15m)/length(test_err));
        disp('С��2m���ʣ�')
        disp(length(err_2m)/length(test_err));
        disp('С��3m���ʣ�')
        disp(length(err_3m)/length(test_err));
        %% ѭ������,Ѱ������goal, spread
        res_goal = [res_goal; goal];
        res_spread = [res_spread; spread];
        res_err = [res_err; testerr_aver];
        res_05err = [res_05err; length(err_05m)/length(test_err)];
        res_1err = [res_1err; length(err_1m)/length(test_err)];
        res_2err = [res_2err; length(err_2m)/length(test_err)];
        res_3err = [res_3err; length(err_3m)/length(test_err)];
        
    end
end
