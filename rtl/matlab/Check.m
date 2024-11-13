clc;
close all;
PATH = 'C:/Users/Administrator/Desktop/BaiduNetdiskDownload/OFDM_802.11a_my/TX/matlab/test/';
%% 串并转换
test_data = load([PATH,'test_data.txt'])';%读取
display(test_data);
FPGA_P2S = load([PATH,'P2S_data_out.txt'])';
display(FPGA_P2S);
check_P2S = test_data == FPGA_P2S; 
display(check_P2S);
%% 扰码
FPGA_scram_dout = load([PATH,'scram_data_out.txt'])';
display(scram_out0);
display(FPGA_scram_dout);
check_scram = FPGA_scram_dout == scram_out0;
display(check_scram);
%% 卷积编码
FPGA_conv_dout = load([PATH,'conv_data_out.txt'])';
display(conv_out0);
display(FPGA_conv_dout);
check_conv = FPGA_conv_dout == conv_out0;
display(check_conv);
%% 删余
FPGA_punt_dout = load([PATH,'punt_data_out.txt'])';
display(conv_out);
display(FPGA_punt_dout);
check_punt = FPGA_punt_dout == conv_out;
display(check_punt);
%% 一级交织
FPGA_intv1_dout = load([PATH,'intv1_data_out.txt'])';
display(int_lea_1_out);
display(FPGA_intv1_dout);
check_intv1 = FPGA_intv1_dout == int_lea_1_out;
display(check_intv1);
%% 二级交织
FPGA_intv2_dout = load([PATH,'intv2_data_out.txt'])';
display(int_lea_2_out);
display(FPGA_intv2_dout);
check_intv2 = FPGA_intv2_dout == int_lea_2_out;
display(check_intv2);
%% 调制映射
FPGA_Re_map_dout = readlines([PATH,'map_Re_data_out.txt'],'EmptyLineRule','skip')';
FPGA_Im_map_dout = readlines([PATH,'map_Im_data_out.txt'],'EmptyLineRule','skip')';
% FPGA_Re_map_dout = load([PATH,'map_Re_data_out.txt'])';
% FPGA_Im_map_dout = load([PATH,'map_Im_data_out.txt'])';
% display(FPGA_Re_map_dout);
% display(FPGA_Im_map_dout);
q = quantizer('fixed','round','saturate',[8,6]);
FPGA_Re_map_dout = bin2num(q,FPGA_Re_map_dout);
FPGA_Im_map_dout = bin2num(q,FPGA_Im_map_dout);
FPGA_Re_map_dout = cell2mat(FPGA_Re_map_dout);
FPGA_Im_map_dout = cell2mat(FPGA_Im_map_dout);
FPGA_map_dout = FPGA_Re_map_dout + 1j*FPGA_Im_map_dout;
display(mod_out.');
display(FPGA_map_dout);
check_map = FPGA_map_dout == mod_out.';
display(check_map);
%% 插入导频
FPGA_pilot_dout = readlines([PATH,'pilot_data_out.txt'],'EmptyLineRule','skip')';
display(FPGA_pilot_dout);
FPGA_Im_pilot_dout = extractBefore(FPGA_pilot_dout,9);
FPGA_Re_pilot_dout = extractAfter(FPGA_pilot_dout,8);
display(FPGA_Re_pilot_dout);
display(FPGA_Im_pilot_dout);
q = quantizer('fixed','round','saturate',[8,6]);
FPGA_Re_pilot_dout = bin2num(q,FPGA_Re_pilot_dout);
FPGA_Im_pilot_dout = bin2num(q,FPGA_Im_pilot_dout);
FPGA_Re_pilot_dout = cell2mat(FPGA_Re_pilot_dout);
FPGA_Im_pilot_dout = cell2mat(FPGA_Im_pilot_dout);
FPGA_pilot_dout = FPGA_Re_pilot_dout + 1j*FPGA_Im_pilot_dout;
% display(interFrq_out);
display(FPGA_pilot_dout);
check_pilot = FPGA_pilot_dout == interFrq_out;
display(check_pilot);
%% IFFT,CP,加窗
FPGA_ifft_dout = readlines([PATH,'ifft_data_out.txt'],'EmptyLineRule','skip')';
display(FPGA_ifft_dout);
FPGA_Im_ifft_dout = extractBefore(FPGA_ifft_dout,9);
FPGA_Re_ifft_dout = extractAfter(FPGA_ifft_dout,8);
display(FPGA_Re_ifft_dout);
display(FPGA_Im_ifft_dout);
q = quantizer('fixed','round','saturate',[8,6]);
FPGA_Re_ifft_dout = bin2num(q,FPGA_Re_ifft_dout);
FPGA_Im_ifft_dout = bin2num(q,FPGA_Im_ifft_dout);
FPGA_Re_ifft_dout = cell2mat(FPGA_Re_ifft_dout);
FPGA_Im_ifft_dout = cell2mat(FPGA_Im_ifft_dout);
FPGA_ifft_dout = FPGA_Re_ifft_dout + 1j*FPGA_Im_ifft_dout;
add_cp_out = add_cp_out / max(abs(add_cp_out));
FPGA_ifft_dout = FPGA_ifft_dout /max(abs(FPGA_ifft_dout));%归一化
display(add_cp_out);
display(FPGA_ifft_dout);
figure;
subplot(2,1,1);
plot(real(add_cp_out));title('Matlab IFFT后实部');
subplot(2,1,2);
plot(real(FPGA_ifft_dout));title('FPGA   IFFT后实部');
figure;
subplot(2,1,1);
plot(imag(add_cp_out));title('Matlab IFFT后虚部');
subplot(2,1,2);
plot(imag(FPGA_ifft_dout));title('FPGA   IFFT后虚部');
%% STS
FPGA_STS_dout = readlines([PATH,'STS_data_out.txt'],'EmptyLineRule','skip')';
display(FPGA_STS_dout);
FPGA_Im_STS_dout = extractBefore(FPGA_STS_dout,9);
FPGA_Re_STS_dout = extractAfter(FPGA_STS_dout,8);
q = quantizer('fixed','round','saturate',[8,6]);
FPGA_Re_STS_dout = bin2num(q,FPGA_Re_STS_dout);
FPGA_Im_STS_dout = bin2num(q,FPGA_Im_STS_dout);
FPGA_Re_STS_dout = cell2mat(FPGA_Re_STS_dout);
FPGA_Im_STS_dout = cell2mat(FPGA_Im_STS_dout);
FPGA_STS_dout = FPGA_Re_STS_dout + 1j*FPGA_Im_STS_dout;
sts_rom_q = num2bin(q,sts_rom);%量化
sts_rom = bin2num(q,sts_rom_q);%反量化
check_STS = FPGA_STS_dout == sts_rom.';
display(check_STS);
%% LTS
FPGA_LTS_dout = readlines([PATH,'LTS_data_out.txt'],'EmptyLineRule','skip')';
display(FPGA_LTS_dout);
FPGA_Im_LTS_dout = extractBefore(FPGA_LTS_dout,9);
FPGA_Re_LTS_dout = extractAfter(FPGA_LTS_dout,8);
q = quantizer('fixed','round','saturate',[8,6]);
FPGA_Re_LTS_dout = bin2num(q,FPGA_Re_LTS_dout);
FPGA_Im_LTS_dout = bin2num(q,FPGA_Im_LTS_dout);
FPGA_Re_LTS_dout = cell2mat(FPGA_Re_LTS_dout);
FPGA_Im_LTS_dout = cell2mat(FPGA_Im_LTS_dout);
FPGA_LTS_dout = FPGA_Re_LTS_dout + 1j*FPGA_Im_LTS_dout;
lts_rom_q = num2bin(q,lts_rom);%量化
lts_rom = bin2num(q,lts_rom_q);%反量化
check_LTS = FPGA_LTS_dout == lts_rom.';
display(check_LTS);
%% symbol_train
FPGA_train_dout = readlines([PATH,'train_data_out.txt'],'EmptyLineRule','skip')';
display(FPGA_train_dout);
FPGA_Im_train_dout = extractBefore(FPGA_train_dout,9);
FPGA_Re_train_dout = extractAfter(FPGA_train_dout,8);
q = quantizer('fixed','round','saturate',[8,6]);
FPGA_Re_train_dout = bin2num(q,FPGA_Re_train_dout);
FPGA_Im_train_dout = bin2num(q,FPGA_Im_train_dout);
FPGA_Re_train_dout = cell2mat(FPGA_Re_train_dout);
FPGA_Im_train_dout = cell2mat(FPGA_Im_train_dout);
FPGA_train_dout = FPGA_Re_train_dout + 1j*FPGA_Im_train_dout;
preamble_q = num2bin(q,preamble);%量化
preamble = bin2num(q,preamble_q);%反量化
check_train = FPGA_train_dout == preamble.';
display(check_train); 
display(preamble(161));%对比加窗的点
display(FPGA_train_dout(161));
%% MCU
FPGA_mcu_dout = load([PATH,'mcu_data_out.txt'])';
display(FPGA_mcu_dout);
check_signal_preamble = signal_preamble == FPGA_mcu_dout(1:24);
display(check_signal_preamble);
 