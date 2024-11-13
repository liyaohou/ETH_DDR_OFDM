function plotPulseWave(binaryData)
    % binaryData: 输入的二进制数据，形式为一个向量

    % 将二进制数据转换为对应的电平值
    waveData = binaryData * 1; % 1代表高电平，0代表低电平

    % 创建时间向量，假设每个位的持续时间为1单位时间
    t = 0:length(waveData)-1;

    % 绘制脉冲波形图
    figure; % 创建一个新的图形窗口
    stem(t, waveData, 'filled'); % 绘制脉冲
    grid on; % 显示网格
    xlabel('Time (s)'); % x轴标签
    ylabel('Amplitude (V)'); % y轴标签
    title('Pulse Waveform'); % 图形标题
    ylim([-0.5 1.5]); % 设置y轴范围，留出一些空间以便于观察
    axis([0 max(t)+1 0 1]); % 设置x轴和y轴的范围
end