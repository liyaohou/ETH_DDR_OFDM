function out = convert2to1bit(in)
    % in: 输入的n个2bit数据，形式为一个n元素的向量
    % out: 输出的2n个1bit数据，形式为一个2n元素的向量

    n = length(in); % 获取输入向量的长度
    out = zeros(2*n, 1); % 初始化输出向量

    for i = 1:n
        % 将每个2bit数据拆分为两个1bit数据
        out(2*i-1) = bitget(in(i), 1); % 获取高1位
        out(2*i) = bitget(in(i), 2); % 获取低1位
    end
end