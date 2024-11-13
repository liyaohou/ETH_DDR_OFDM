close all;
clear;
clc;
%10101010_01010101_11110000_01010101
send_data = [1,0,1,0,1,0,1,0,0,0,0,0,1,1,1,1,1,0,1,0,1,0,1,0,0,1,0,1,0,1,0,1];  
scram_out = bit_scramble(send_data);
n = 2;
k = 1;
rate = k/n; % rate为 1/2
L = 7;
tblen = 5*(L-1); % 回溯深度
trellis = poly2trellis(L,[171 133]);
cloun= convenc(scram_out,trellis) ;
code_data = transpose (cloun );

summed_data = code_data(1:2:end) + 2 * code_data(2:2:end);