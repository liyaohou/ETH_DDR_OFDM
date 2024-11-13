%% 本仿真基于IEEE802.11a
clc;
clear;
close all;
%% 原始序列输入 
num_in = round(rand(1,1e4));  
%% 参数设置
%调制参数设置
M = 4;      %调制阶数。1-BPSK，2-QPSK,3-8QAM,4-16QAM，5-32QAM,6-64QAM
k = 20 ;    %OFDM符号数
code_rate = 6; %卷积编码速率。12--无卷积编码，9--3/4速率，6--1/2速率，8--2/3速率
leng_num_in = k .* 48 .* M ./12 .* code_rate;%leng_num_in /8 = 一个symbol字节数

disp(leng_num_in);
num_in = num_in(1:leng_num_in);     %截取输入序列长度
%%写txt文件
fid= fopen('C:/Users/fire/Desktop/OFDM_802.11a_my/TX/matlab/test/test_data.txt','w');
fprintf(fid,'%d\r\n',num_in);
fclose(fid);
%% signal帧数据生成 
%RATE = [R1 R2 R3 R4] 字段
tx_rate = 48 * M * code_rate / 12 /4;
switch(tx_rate)
    case 6
        RATE = [1 1 0 1];
    case 9
        RATE = [1 1 1 1];
    case 12
        RATE = [0 1 0 1];
    case 18
        RATE = [0 1 1 1];
    case 24
        RATE = [1 0 0 1];
    case 36
        RATE = [1 0 1 1];
    case 48
        RATE = [0 0 0 1];
    case 54
        RATE = [0 0 1 1];
    otherwise
        disp('tx_rate_error');
end
%保留位
R = 0;
%LENGTH字段：LSB-MSB（bit5-16）
byte_len = dec2bin(leng_num_in/8,12);
for m = 1:12
    LENGTH(12-m+1) = str2num(byte_len(m)); 
end
%偶校验位
EVEN_PARITY = mod(sum([RATE,R,LENGTH]),2);
%尾bit
TAIL = [0 0 0 0 0 0];
%组帧
signal_preamble = [RATE,R,LENGTH,EVEN_PARITY,TAIL];
%信道参数设置 
SNR = 10;   %信噪比
fc = 70e6;  %载波频率
fs = 200e6;     %采样频率
phase_py = 0;    %载波相偏
freq_py = 0;     %载波频偏
%莱斯信道设置
ricianChan = comm.RicianChannel(...
        "SampleRate",             20e6,...scram_out0
        'PathDelays',             [1.7*50e-9, 2.8*50e-9], ...
        'AveragePathGains',       [-5,-8], ...
        "KFactor",                10,...
        'NormalizePathGains',     true, ... 
        "DirectPathDopplerShift", 20,...
        "MaximumDopplerShift",    10,...
        "RandomStream",           "mt19937ar with seed",...
        "Seed",                   38);
%% 扰码
scram_seed0 = [1,0,1,1,1,0,1];       %扰码寄存器初值
scramnler = scram_seed0;             %扰码寄存器                                                      %数据个数        
scram_in = num_in;        %产生输入随机序列
scram_out0 = zeros(1,length(num_in));             %初始化输出序列
for m = 1:length(scram_in)
    scram_out0(m) = mod(scramnler(7) + scramnler(4) + scram_in(m), 2);       %扰码：7+4+输入数据
    scramnler = [mod(scramnler(7) + scramnler(4), 2),scramnler(:,1:6)];     %扰码寄存器移位，最低位为7+4
end
%% 卷积编码
conv_in = scram_out0;    
L = 7;          %卷积编码约束长度
trellis = poly2trellis(L,[133,171]);
conv_out0 = convenc(conv_in,trellis);
%% 删余
switch(code_rate)   %卷积编码速率控制
    case 12  
        conv_out = conv_in;%做卷积编码
    case 8  
        puncpat = [1;1;1;0];    %打孔方式
        trellis = poly2trellis(L,[133,171]);
        conv_out = convenc(conv_in,trellis,puncpat);
    case 6
        puncpat = [1;1;1;1];
        trellis = poly2trellis(L,[133,171]);
        conv_out = convenc(conv_in,trellis,puncpat);
    case 9
        puncpat = [1;1;1;0;0;1];
        trellis = poly2trellis(L,[133, 171]);
        conv_out = convenc(conv_in,trellis,puncpat);
    otherwise
        disp('code_rate_error');
end
%% 一级交织
%一级交织器产生：16*list 列写行读
conv_out_Len = length(conv_out);    %编码后的长度
symbol_Len = conv_out_Len / k;      %单个符号码长度
list = conv_out_Len / k / 16;       %一级交织的列数
row = length(conv_out)/list;        %将数据转为list列的矩阵 
ram = zeros(row,list);              %将输入数据存储在list列，row行的矩阵中
for n = 1:k                         %将ram矩阵拆为n个16*list的矩阵，每次写入list列
    for m = 1:symbol_Len            %以列写入
        row_index = mod(m-1,16)+1;      %写入到矩阵中行的位置
        list_index = ceil(m/16);           %写入到矩阵中列的位置
        ram((n-1)*16+row_index,list_index) = conv_out((n-1)*symbol_Len+m); %将数据写入ram矩阵
    end
end
int_lea_1_out = zeros(1,conv_out_Len);
for n = 1:k
    for row_index = 1:16
        for list_index = 1:list    %按行读出ram中的数据，每次读list列
            int_lea_1_out((n-1)*symbol_Len+(row_index-1)*list+list_index) = ...
            ram(((n-1)*16+row_index),list_index);
        end
    end
end
%% 二级交织
int_lea_2_out = int_lea_1_out;
for index = 1:symbol_Len*k         %数据前12个不变，接下来12个两两交换位置
        if(mod((ceil(index/12)-1),2)==1)    %判断数据是不是在后12个位置
            if(mod(index,2) == 0)           %在偶数位置时，将前一个位置的数据给他
                int_lea_2_out(index) = int_lea_1_out(index-1);
            else                            %在奇数位置时，将后一个位置的数据给他
                int_lea_2_out(index) = int_lea_1_out(index+1);
            end
        else
            int_lea_2_out(index) = int_lea_1_out(index);    
        end
end
%% 调制映射
mod_out = qammod(int_lea_2_out', 2^M, 'InputType', 'bit', 'UnitAveragePower', true, 'PlotConstellation', true)';
q = quantizer('fixed','round','saturate',[8,6]);%复数以8位定点数形式进行输出，格式为：1位符号位，一位整数位，6位小数位，负数以补码形式表示。
mod_out_q = num2bin(q,mod_out);%量化
mod_out = bin2num(q,mod_out_q);%反量化
%% 插入导频到7，21，43，57，由于matlab下标从1开始，这里插入导频位置为8，22，44，58
%插入导频极性控制，扰码
scram_seed2 = [1,1,1,1,1,1,1];
scram_reg = scram_seed2;
scram_out = zeros(1,k);
for m = 1:k
    scram_out(m) = mod(scram_reg(1) + scram_reg(4), 2);
    scram_reg(:,1:end) = [scram_reg(:,2:end), mod(scram_reg(1) + scram_reg(4), 2)];     %扰码寄存器移位，最低位为7+4
    if(m==127)
        scram_reg = scram_seed2;%127个OFDM符号之后，扰码器恢复初始状态
    end    
end
rx_interFrq = mod_out;
interFrq_out = zeros(1,64*k);
for m = 1:k
    reg48 = rx_interFrq((m-1)*48+1:m*48);
    reg_pn = scram_out(m);
        if(reg_pn)              %当 scram_out== 0 时，不需要极性取反， 当 scram_out==1 时，需要极性取反。
            reg_interFrq = [-1,1,-1,-1];%极性取反
        else
            reg_interFrq = [1,-1,1,1];
        end
        reg64 = zeros(1,64);
        %端口映射为IFFT输入
        reg64(1+38:5+38) = reg48(1:5);
        reg64(6+39:18+39) = reg48(6:18);
        reg64(19+40:24+40) = reg48(19:24);
        reg64(25-23:30-23) = reg48(25:30);
        reg64(31-22:43-22) = reg48(31:43);
        reg64(44-21:48-21) = reg48(44:48);
        %剩下的1，28-38端口置0
        reg64(28:38) = 0;
        reg64(1) = 0;
        %插入导频8，22，44，58
        reg64(8) = reg_interFrq(1);
        reg64(22) = reg_interFrq(2);
        reg64(44) = reg_interFrq(3);
        reg64(58) = reg_interFrq(4);
        interFrq_out((m-1)*64+1:m*64) = reg64;
end
%% IFFT
ifft_in = interFrq_out * 8;
ifft_out = zeros(1,k*64);
for m = 1:k
    reg64 = ifft_in((m-1)*64+1:m*64);
    figure;
    subplot(2,1,1);
    plot(real(reg64));title('频域实部',m);
    subplot(2,1,2);
    plot(imag(reg64));title('频域虚部',m);
    reg_ifft = ifft(reg64);
    ifft_out((m-1)*64+1:m*64) = reg_ifft;
    figure;
    subplot(2,1,1);
    plot(real(reg_ifft));title('时域实部第',m);
    subplot(2,1,2);
    plot(imag(reg_ifft));title('时域虚部',m);   
end
%% 加循环前缀CP，加窗
add_cp_in = ifft_out;
add_cp_out = zeros(1,80*k);
reg80 = zeros(1,80);
tmp_end = zeros(1,k+1);
for m = 1:k
    reg64 = add_cp_in((m-1)*64+1:m*64);
    reg80(1:16) = reg64((end-15):end);
    reg80(17:end) = reg64(1:end);
    tmp_end(m+1) = 0.5*reg64(1);
    add_cp_out((m-1)*80+1:m*80) = [0.5*tmp_end(m)+0.5*reg80(1),reg80(2:end)] ;
end
%% 加帧头
%产生长短训练序列、帧头
short_training =[0,0,0,0,-1-1i,0,0,0,-1-1i,0,0,0,1+1i,0,0,0,1+ ...
    1i,0,0,0,1+1i,0,0,0,1+1i,0,0,0,0,0,0,0,0,0,0,0,0,0,...
    0,0,1+1i,0,0,0,-1-1i,0,0,0,1+1i,0,0,0,-1-1i, ...
    0,0,0,-1-1i,0,0,0,1+1i,0,0,0]; % short training sequence
sts_frq = (13/6)^0.5 .* short_training;
sts_time = 8*ifft(sts_frq,64);    %对短训练序列进行ifft
%取16点，将该序列重复10次
sts16 = sts_time(1:16);
sts16_q = num2bin(q,sts16);%量化,存到FPGA的ROM
sts_rom = sts16;
for n = 1:9
    sts_rom = [sts_rom,sts16];
end
sts_rom = [0.5*sts_rom(1),sts_rom(2:end),0.5*sts16(1)];     %加窗

lts = [ 0,1,-1,-1,1,1,-1,1,-1,1,-1,-1,-1,-1,-1,1,1,-1,-1,1, ...
    -1,1,-1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,-1,1,1,-1,1,-1,1,1,1,1,1,1,...
    -1,-1,1,1,-1,1,-1,1,1,1,1 ];
lts_time = 8 * ifft(lts,64);        %长训练序列进行ifft
q = quantizer('fixed','round','saturate',[8,6]);%复数以8位定点数形式进行输出，格式为：1位符号位，一位整数位，6位小数位，负数以补码形式表示。
lts_time_q = num2bin(q,lts_time);%量化,存到FPGA的ROM
lts_rom = [0.5*lts_time(33),lts_time(34:end),lts_time,lts_time,0.5*lts_time(1)];    %长训练序列加窗
preamble = [sts_rom(1:(end-1)),sts_rom(end)+lts_rom(1),lts_rom(2:end)];     %帧头加窗      
%合成帧头与数据
preamble_out = [preamble(1:(end-1)),preamble(end)+add_cp_out(1),add_cp_out(2:end)];