close all;
clear;
clc;
% 定义卷积码的约束长度和生成多项式
constraintLength = 7; % 约束长度
generatorPolynomials = [171 133]; % 生成多项式，以八进制表示
% 创建trellis结构
trellis = poly2trellis(constraintLength, generatorPolynomials);

% 定义编码数据的长度，确保是约束长度的倍数
numBits = 1000; % 编码数据的位数
dataIn = randi([0 1], numBits, 1); % 生成随机二进制数据

% 卷积编码
encodedData = [1 1, 0 0 0 0 0 0, 1 1 1 1 1 1 1 1, 0 0, 1 1, 0 0 0 0 0 0 0 0,1 1 ,0 0 0 0 0 0 0 0 , 1 1 1 1 ,0 0, 1 1 ,0 0 ];

% 假设通过AWGN信道传输，这里直接进行Viterbi译码
% 定义回溯深度，通常取约束长度的3到4倍
tracebackDepth = 4 * (constraintLength - 1);

% Viterbi译码
decodedData = vitdec(encodedData, trellis, tracebackDepth, 'trunc', 'hard');

% 显示原始数据和译码后的数据，以便比较
disp('Original Data:');
disp(dataIn);

disp('Decoded Data:');
disp(decodedData);