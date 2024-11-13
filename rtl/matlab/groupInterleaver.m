function interleaveData = groupInterleaver(direction, m, n, data)
%交织 column   解交织 row
%行的个数m
%列的个数n
%48---交织时16列进3行出 column
%48---解交织3行进16列出 row
    % 检查输入数据长度是否正确
    if length(data) ~= m * n
        error('Data length must be equal to m * n.');
    end
    
    % 初始化交织后的数据串
    interleaveData = zeros(1, m * n);
    
    % 根据方向选择交织方式
    if strcmp(direction, 'column')
        % 列进行出
        for i = 1:n
            for j = 1:m
                interleaveData((i - 1) * m + j) = data((j - 1) * n + i);
            end
        end
    elseif strcmp(direction, 'row')
        % 行进列出
        for i = 1:m
            for j = 1:n
                interleaveData((i - 1) * n + j) = data((j - 1) * m + i);
            end
        end
    else
        error('Direction must be either "column" or "row".');
    end
end