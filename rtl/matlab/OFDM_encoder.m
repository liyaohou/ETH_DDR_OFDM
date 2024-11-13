close all;
clear;
clc;
%%扰码部分
data_to_scram = [1 0 1 0 1 0 1 0 ,0 0 0 0 1 1 1 1 ,1 0 1 0 1 0 1 0, 0 1 0 1 0 1 0 1];

u_scram_out = bit_scramble(data_to_scram);

%%编码部分
data_to_encoder = u_scram_out;

n = 2;
k = 1;
rate = k/n; % rate为 1/2
L = 7;
tblen = 5*(L-1); % 回溯深度
trellis = poly2trellis(L,[171 133]);

u_encoder_out = convenc(data_to_encoder,trellis) ;
encoder_out_par = u_encoder_out(1:2:end) + 2 * u_encoder_out(2:2:end);

%%1级交织部分
%data_to_intv1 = u_encoder_out;
data_to_intv1 = [0 0 1 0 1 1 0 1,1 1 1 0 0 1 0 0,1 1 1 1 1 0 0 0 ,1 1 0 1 0 1 1 0,0 0 1 1 1 0 1 0,0 0 0 0 0 1 0 1] ;
u_intv1_out = groupInterleaver("column",3,16,data_to_intv1);

%%2级交织部分
data_to_intv2 = u_intv1_out;
u_intv2_out = secondaryInterleaver(data_to_intv2);

%%2级解交织部分
data_to_deintv2 = u_intv2_out;
u_deintv2_out = secondaryInterleaver(data_to_deintv2);

%%1级解交织部分
data_to_deintv1 = u_deintv2_out;
u_deintv1_out = groupInterleaver("row",3,16,data_to_deintv1);

%%译码部分
%data_to_decode = u_deintv1_out;
data_to_be_bitstream = [1 1 3 2, 2 0 2 2 ,2 0 1 1, 1 3 1 2];
data_to_decode = convert2to1bit(data_to_be_bitstream);
% 定义卷积码的约束长度和生成多项式
constraintLength = 7; % 约束长度
generatorPolynomials = [171 133]; % 生成多项式，以八进制表示
% 创建trellis结构
trellis = poly2trellis(constraintLength, generatorPolynomials);
% 定义回溯深度，通常取约束长度的3到4倍
tracebackDepth = 2 * (constraintLength - 1);
% Viterbi译码
u_decoder_out = vitdec(data_to_decode, trellis, tracebackDepth, 'trunc', 'hard')
plotPulseWave(u_decoder_out);
%%解扰部分

