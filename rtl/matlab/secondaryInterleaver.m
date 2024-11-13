function interleaveData = secondaryInterleaver(data)
    % 检查输入数据长度是否为24的倍数
    if mod(length(data), 24) ~= 0
        error('Data length must be a multiple of 24.');
    end
    
    % 初始化交织后的数据串
    interleaveData = zeros(1, length(data));
    
    % 按24个bit一组进行交织
    for i = 1:24:length(data)
        % 提取每组的前12个bit
        interleaveData(i:i+11) = data(i:i+11);
        % 提取每组的后12个bit并两两交换
        swappedBits = zeros(1, 12);
        swappedBits(1:2:end) = data(i+13:2:i+24);
        swappedBits(2:2:end) = data(i+12:2:i+23);
        
        interleaveData(i+12:i+23) = swappedBits; 
    end
end