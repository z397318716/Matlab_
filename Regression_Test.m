[num1] = xlsread('PTU_R06_12.xlsx', 1, 'D3:Q1442' );    %数据范围: D3-Q1442
[num2] = xlsread('VIS_R06_12.xlsx', 1, 'D3:Z5756' );    %数据范围: D3-Z5757
[num3] = xlsread('WIND_R06_12.xlsx', 1, 'D3:W5757' );    %数据范围: D3-W5757

% 只重复3次的数据位置 87(1:26) 481(8:00) 637(10:36) 742(12:21) 1399(23:18)
[num11] = xlsread('PTU_R06_15.xlsx', 1, 'D3:Q1442' );    %数据范围: D3-Q1442
[num22] = xlsread('VIS_R06_15.xlsx', 1, 'D3:Z5756' );    %数据范围: D3-Z5757
[num33] = xlsread('WIND_R06_15.xlsx', 1, 'D3:W5757' );    %数据范围: D3-W5757

% PTU----每分钟采集1一次, 共1440组数据    75(1:12) 3次 608(10:05) 3次  812(13:29) 3次  1062(17:39) 3次 1214(20:11) 三次
% 而其它数据都是1秒采集4次,所以需要对PTU表中的数据进行扩充,每个数字重复4次
x1_1 = (num1(:,1))';  % PAINS（HPA）   本站气压
x2_2 = (num1(:,2))';  % QNH 			修正海平面气压
x3_3 = (num1(:,4))';  % QFE R06  		飞机着陆地区最高点气压
x4_4 = (num1(:,11))'; % TEMP 			温度
x5_5 = (num1(:,12))'; % RH				相对湿度
x6_6 = (num1(:,13))';    %DEWPOINT		露点温度

x1 = [];
x2 = [];
x3 = [];
x4 = [];
x5 = [];
x6 = [];
% VIS
x7 = (num2(:,2))';  % RVR_1A 		1分钟平均RVR值
x8 = (num2(:,10))';  % MOR_1A 		1分钟平均MOR值
x9 = (num2(:,21))';  % LIGHT_S		灯光数据
x7 = [x7, 125];
x8 = [x8, 50];
x9 = [x9, 10];
% 
x10 = (num3(:,3))';  % WS2A 		2分钟平均风速
x11 = (num3(:,11))';  % WD2A		2分钟平均风向
x12 = (num3(:,20))';  % CW2A		2分钟平均垂直风速
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

d1_1 = (num11(:,1))';  % PAINS（HPA）   本站气压
d2_2 = (num11(:,2))';  % QNH 			修正海平面气压
d3_3 = (num11(:,4))';  % QFE R06  		飞机着陆地区最高点气压
d4_4 = (num11(:,11))'; % TEMP 			温度
d5_5 = (num11(:,12))'; % RH				相对湿度
d6_6 = (num11(:,13))';    %DEWPOINT		露点温度
d1 = [];
d2 = [];
d3 = [];
d4 = [];
d5 = [];
d6 = [];

d7 = (num22(:,2))';  % RVR_1A 		1分钟平均RVR值
d8 = (num22(:,10))';  % MOR_1A 		1分钟平均MOR值
d9 = (num22(:,21))';  % LIGHT_S		灯光数据
d7 = [d7, 200];
d8 = [d8, 50];
d9 = [d9, 100];
% 
d10 = (num33(:,3))';  % WS2A 		2分钟平均风速
d11 = (num33(:,11))';  % WD2A		2分钟平均风向
d12 = (num33(:,20))';  % CW2A		2分钟平均垂直风速
% 只重复3次的数据位置 87(1:26) 481(8:00) 637(10:36) 742(12:21) 1399(23:18)
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

t = 1 : length(x1);
y = [];
for i = 1 : length(x1)
    tmp = 124.984 - 0.115332*x1(i) - 0.00140765*x9(i) - 0.252763*x10(i) - 0.00631716*x11(i)+0.180889*x12(i);
    y = [y,tmp];
end
out_train = [];
for i = 1 : length(x7)
    tmp = log(x7(i));
    out_train = [out_train, tmp]; 
end
%输入数据---考虑温度(x4),相对湿度(x5),露点温度(x6)平均风速(x10) 平均风向(x11) 垂直风速(x12)
figure();
%scatter(x10,x7,'r');
%plot(x10,x7);
plot(t, y,'-r',t, out_train,'b')
legend('拟合数据','原始数据')