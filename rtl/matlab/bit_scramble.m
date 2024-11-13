% 函数功能：扰码
% 输入：din、g
% 输出：dout
% 生成多项式：g = [1 0 0 0_0 0 0 0_0 0 0 0_0 0 1 1];低位--->高位
% 移位寄存器输入:sr_in


function dout = bit_scramble(din)

g = [1 0 1 1 1 0 1];

% 移位寄存器初始化
sr_reg = [1 0 1 1 1 0 1];
dout = zeros(1,length(din));

for clk = 1:length(din)
    
    % 组合逻辑
    sr_in = mod(sr_reg(4)+sr_reg(7),2);
    dout(clk) = mod(din(clk)+sr_in,2);
    
    % 时序逻辑
    sr_reg(2:end) = sr_reg(1:end-1);
    sr_reg(1) = sr_in;
    
end

end


