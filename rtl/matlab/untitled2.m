%王科文/姚双/刘银杰/杨昊  重庆工商大学
function main3
% LabName:             卷积编解码实验
% Task:                生成数据长度为10的比特数据源
%                       约束长度为7，生成多项式进行1/2卷积编码
%                       解码可用Matlab自带函数vitdec进行译码
%                       统计译码比特和数据源的误码数
close all
% 创建主窗口
fig = figure('Name', '卷积编解码实验', 'NumberTitle', 'off', 'Position', [50, 380, 700, 400]);
% 设置采样率和码元速率
fs = 30720000; % 采样率
Rb = 153600;   % 码元速率
 
% 生成数据源
dataBit = [];
code_data_s = [];
decode_data_s = [];
errorNum = [];
zhuangtai=[];
% 创建按钮和文本框
uicontrol("Style",'text','Position',[10,350,330,30],'String','①(指定错误)输入引入错误的位置','FontSize',14)
uicontrol("Style",'text','Position',[340,350,330,30],'String','②(随机错误)输入随机错误的个数','FontSize',14)
uicontrol("Style",'text','Position',[230,260,200,30],'String','随机10位数据源显示：','FontSize',14)
uicontrol("Style",'text','Position',[230,200,200,30],'String','手动10位数据源输入：','FontSize',14)
uicontrol("Style",'text','Position',[230,140,200,30],'String','10位卷积码译码显示：','FontSize',14)
uicontrol("Style",'text','Position',[20,50,180,30],'String','对应32位编码显示:','FontSize',14)
uicontrol("Style",'text','Position',[230,90,200,30],'String','纠错位置显示：','FontSize',14)
%dataBit11=uicontrol('Style', 'edit', 'String', '', 'Position', [400, 160, 200, 30]);%随机显示文本框
d=uicontrol('Style', 'edit', 'String', '', 'Position', [450, 140, 200, 30]);
e=uicontrol('Style', 'edit', 'String', '', 'Position', [450, 90, 200, 30]);
a=uicontrol('Style', 'edit', 'String', '', 'Position', [450, 200, 200, 90], 'Callback', @(src, event) updateManualInput(src, event));%手动输入文本框
b=uicontrol('Style', 'edit', 'String', '2(输入格式)', 'Position', [400, 320, 200, 30],'Callback', @(src, event) updateManualInput2(src, event));%输入错误个数文本框
c=uicontrol('Style', 'edit', 'String', '1 2 5(输入格式·)', 'Position', [60, 320, 200, 30],'Callback',@(src, event) updateManualInput1(src, event));%输入错误位置文本框
code=uicontrol('Style', 'edit', 'String', '', 'Position', [200, 50, 450, 30]);%编码显示文本框
uicontrol('Style', 'pushbutton', 'String', '随机生成数据源', 'Position', [60, 260, 150, 30], 'Callback', @(src, event) generateRandomData(src, event,a,d,e, code,fs, Rb));
uicontrol('Style', 'pushbutton', 'String', '手动输入数据源', 'Position', [60, 200, 150, 30], 'Callback', @(src, event) manualInputData(src, event,d,e,code, fs, Rb));
uicontrol('Style', 'pushbutton', 'String', '本(2,1,7)卷积码状态转移显示', 'Position', [400, 10, 200, 30], 'Callback', @(src, event) bianma());
set(fig,'UserData',struct('a',a,'b',b,'c',c));
 
function bianma()
    figure('Name', '卷积编码规则', 'NumberTitle', 'off', 'Position', [750, 100, 800, 580]);
    A1=[0.05,0.7];
    B1=[0.95,0.7];
    annotation("arrow",[A1(1),B1(1)],[A1(2),B1(2)]);
    zhuangtai1=uicontrol('Style', 'edit', 'String', '', 'Position', [180, 515, 200, 35],'Callback', @(src, event) updateManualInput3(src, event));
    uicontrol("Style",'text','Position',[25,350,700,30],'String','输入位A             M1               M2              M3               M4                M5               M6','FontSize',14)
    uicontrol("Style",'text','Position',[20,220,550,30],'String','（2，1，7）卷积码第一位输出编码(A+M1+M2+M3+M6)(模2加)','FontSize',14)
    uicontrol("Style",'text','Position',[20,160,550,30],'String','（2，1，7）卷积码第二位输出编码(A+M2+M3+M5+M6)(模2加)','FontSize',14)
    uicontrol("Style",'text','Position',[10,100,500,30],'String','寄存器(M1 M2 M3 M4 M5 M6)目前状态为:','FontSize',14)
    uicontrol("Style",'text','Position',[10,40,500,30],'String','寄存器(M1 M2 M3 M4 M5 M6)下一状态为:','FontSize',14)
    shuru=uicontrol('Style', 'edit', 'String', '0', 'Position', [60, 300, 50, 30]);
    M1=uicontrol('Style', 'edit', 'String', '0', 'Position', [160, 300, 50, 30]);
    M2=uicontrol('Style', 'edit', 'String', '0', 'Position', [260, 300, 50, 30]);
    M3=uicontrol('Style', 'edit', 'String', '0', 'Position', [360, 300, 50, 30]);
    M4=uicontrol('Style', 'edit', 'String', '0', 'Position', [460, 300, 50, 30]);
    M5=uicontrol('Style', 'edit', 'String', '0', 'Position', [560, 300, 50, 30]);
    M6=uicontrol('Style', 'edit', 'String', '0', 'Position', [660, 300, 50, 30]);
    now1=uicontrol('Style', 'edit', 'String', '0', 'Position', [450, 100, 200, 30]);
    next1=uicontrol('Style', 'edit', 'String', '0', 'Position', [450, 40, 200, 30]);
    bianma1=uicontrol('Style', 'edit', 'String', '', 'Position', [600, 220, 50, 40]);
    bianma2=uicontrol('Style', 'edit', 'String', '', 'Position', [600, 160, 50, 40]);
    uicontrol('Style', 'pushbutton', 'String', '填入状态', 'Position', [50, 515, 100, 35], 'Callback', {@subButtonCallback, zhuangtai1,shuru, ...
                                                                                     M1,M2,M3,M4,M5,M6,now1,bianma1,bianma2,next1});
    uicontrol('Style', 'pushbutton', 'String', '输入1', 'Position', [50, 450, 100, 30], 'Callback', {@shu1, shuru,M1,M2,M3,M4,M5,M6,now1,bianma1,bianma2,next1})
    uicontrol('Style', 'pushbutton', 'String', '输入0', 'Position', [210, 450, 100, 30], 'Callback', {@shu0, shuru,M1,M2,M3,M4,M5,M6,now1,bianma1,bianma2,next1})
end
function shu1(~,~,shuru,M1,M2,M3,M4,M5,M6,now1,bianma1,bianma2,next1)
    M61=get(M5,'String');
    M51=get(M4,'String');
    M41=get(M3,'String');
    M31=get(M2,'String');
    M21=get(M1,'String');
    M11=get(shuru,'String');
    now=[M11,M21,M31 ,M41,M51,M61];
    set(now1,'String',now)
    set(shuru,'String',num2str(1))
    set(M1,'String',num2str(M11))
    set(M2,'String',num2str(M21))
    set(M3,'String',num2str(M31))
    set(M4,'String',num2str(M41))
    set(M5,'String',num2str(M51))
    set(M6,'String',num2str(M61))
    f1=xor(1,xor(str2num(M11),xor(str2num(M21),xor(str2num(M31),str2num(M61)))));
    f2=xor(1,xor(str2num(M21),xor(str2num(M31),xor(str2num(M51),str2num(M61)))));
    set(bianma1,'String',num2str(f1))
    set(bianma2,'String',num2str(f2))
    M611=get(M5,'String');
    M511=get(M4,'String');
    M411=get(M3,'String');
    M311=get(M2,'String');
    M211=get(M1,'String');
    M111=get(shuru,'String');
    next=[M111,M211,M311 ,M411,M511,M611];
    set(next1,'String',next)
end
function shu0(~,~,shuru,M1,M2,M3,M4,M5,M6,now1,bianma1,bianma2,next1)
    M61=get(M5,'String');
    M51=get(M4,'String');
    M41=get(M3,'String');
    M31=get(M2,'String');
    M21=get(M1,'String');
    M11=get(shuru,'String');
    now=[M11,M21,M31 ,M41,M51,M61];
    set(now1,'String',now)
    set(shuru,'String',num2str(0))
    set(M1,'String',num2str(M11))
    set(M2,'String',num2str(M21))
    set(M3,'String',num2str(M31))
    set(M4,'String',num2str(M41))
    set(M5,'String',num2str(M51))
    set(M6,'String',num2str(M61))
    f1=xor(0,xor(str2num(M11),xor(str2num(M21),xor(str2num(M31),str2num(M61)))));
    f2=xor(0,xor(str2num(M21),xor(str2num(M31),xor(str2num(M51),str2num(M61)))));
    set(bianma1,'String',num2str(f1))
    set(bianma2,'String',num2str(f2))
    M611=get(M5,'String');
    M511=get(M4,'String');
    M411=get(M3,'String');
    M311=get(M2,'String');
    M211=get(M1,'String');
    M111=get(shuru,'String');
    next=[M111,M211,M311,M411,M511,M611];
    set(next1,'String',next)
end
function subButtonCallback(~, ~, zhuangtai1,shuru,M1,M2,M3,M4,M5,M6,now1,bianma1,bianma2,next1)
    % 读取子窗口文本框的内容
    zhuangtai=get(zhuangtai1,'String');
    f1=xor(str2num(zhuangtai(1)),xor(str2num(zhuangtai(3)),xor(str2num(zhuangtai(5)),xor(str2num(zhuangtai(7)),str2num(zhuangtai(13))))));
    f2=xor(str2num(zhuangtai(1)),xor(str2num(zhuangtai(5)),xor(str2num(zhuangtai(7)),xor(str2num(zhuangtai(11)),str2num(zhuangtai(13))))));
    set(bianma1,'String',num2str(f1))
    set(bianma2,'String',num2str(f2))
    % 将内容填充到另一个文本框中
    set(shuru,'String',num2str(zhuangtai(1)))
    set(M1,'String',num2str(zhuangtai(3)))
    set(M2,'String',num2str(zhuangtai(5)))
    set(M3,'String',num2str(zhuangtai(7)))
    set(M4,'String',num2str(zhuangtai(9)))
    set(M5,'String',num2str(zhuangtai(11)))
    set(M6,'String',num2str(zhuangtai(13)))
    now=[zhuangtai(3),zhuangtai(5),zhuangtai(7),zhuangtai(9),zhuangtai(11),zhuangtai(13)];
    set(now1,'String',now)
    next=[zhuangtai(1),zhuangtai(3),zhuangtai(5),zhuangtai(7),zhuangtai(9),zhuangtai(11)];
    set(next1,'String',next)
end
% 回调函数：随机生成数据源、编码和解码
function generateRandomData(~, ~,a,d,e,code,fs, Rb)
    data=get(gcf,'UserData');
    inputString1 = get(data.b, 'String');
    errors=str2num(inputString1);
    inputString2 = get(data.c, 'String');
    errors11=str2num(inputString2);
    len_in = 10; % 数据源长度
    dataBit = randi([0,1], 1, len_in);
    set(a,'String',num2str(dataBit))
    processData(dataBit,code,d,e,errors,errors11,fs, Rb);
end
% 回调函数：手动输入数据源
function manualInputData(~, ~,d,e, code,fs, Rb)
    data=get(gcf,'UserData');
    inputString = get(data.a, 'String');
    dataBit = str2num(inputString);
    if isempty(dataBit) || ~all(ismember(dataBit, [0, 1]))||length(inputString)~=19
        % 非法输入，清空文本框
        msgbox('请输入有效的10位二进制数据（0和1），每个数据用一个空格隔开', '错误', 'error');
    end
    inputString1 = get(data.b, 'String');
    errors=str2num(inputString1); %#ok<*ST2NM> 
    inputString2 = get(data.c, 'String');
    errors11=str2num(inputString2);
    processData(dataBit, code,d,e,errors,errors11,fs, Rb);
end
% 更新手动输入文本框数据源
function updateManualInput(src, ~)
    inputString = get(src, 'String');
    inputArray = str2num(inputString);
    if isempty(inputArray) || ~all(ismember(inputArray, [0, 1]))||length(inputString)~=19
        % 非法输入，清空文本框
        set(src, 'String', '');
    end
end
%引入错误位置
function updateManualInput1(src, ~)
    inputString = get(src, 'String');
    inputArray = str2num(inputString);
    shun=0:32;
    if ~all(ismember(inputArray, shun))
        % 非法输入，清空文本框
        msgbox('请输入元素为0到32的数组，每个数据用一个空格隔开', '错误', 'error');
        set(src, 'String', '');
    end
end
%输入错误个数
function updateManualInput2(src, ~)
    inputString = get(src, 'String');
    inputArray = str2num(inputString);
    shun=0:32;
    if ~all(ismember(inputArray, shun))||length(inputArray)~=1
        % 非法输入，清空文本框
        msgbox('请输入一个0到32的数', '错误', 'error');
        set(src, 'String', '');
    end
end
% 处理数据
function updateManualInput3(src, ~)
    inputString = get(src, 'String');
    inputArray = str2num(inputString);
   if isempty(inputArray) || ~all(ismember(inputArray, [0, 1]))||length(inputString)~=13
        % 非法输入，清空文本框
        msgbox('请输入有效的7位二进制数据（0和1）,每个数据用一个空格隔开', '错误', 'error');
        set(src, 'String', '');
   end
end
function processData(dataBit, code,d,e,errors,errors11,fs, Rb)
    K = 7; % 约束度
    CodeGenerator = [171, 133]; % 171 为8进制，对应为1 1 1 1 0 0 1 ，133为1 0 1 1 0 1 1
    
    len_in = length(dataBit);
    len_out = (len_in + K - 1) * 2;
    sample_num = fs / Rb; % 1个码元采样点数
    N = len_in * sample_num; % 总样点数
 
    dt = 1 / fs;
    t = 0:dt:(N - 1) * dt;
    N1 = len_out * sample_num;
    t1 = 0:dt:(N1 - 1) * dt;
 
    % 数据源进行卷积编码
    reg = zeros(1, 6);
    sourceBit = [dataBit, zeros(1, 6)];% 加6个尾比特
    len = length(sourceBit);
    first = zeros(1, len);
    second = zeros(1, len);
    code_data = zeros(1, 2 * len); %#ok<*PREALL> 
    for n = 1:len
        first(n) = xor(xor(xor(xor(sourceBit(n), reg(1)), reg(2)), reg(3)), reg(6));
        second(n) = xor(xor(xor(xor(sourceBit(n), reg(2)), reg(3)), reg(5)), reg(6));
        reg(6) = reg(5);
        reg(5) = reg(4);
        reg(4) = reg(3);
        reg(3) = reg(2);
        reg(2) = reg(1);
        reg(1) = sourceBit(n);
        code_data1(1, (n - 1) * 2 + 1 : 2 * n) = [first(n), second(n)];
    end
    code_data1(1,(n-1)*2+1:2*n)=[first(n),second(n)];
    set(code,'String',num2str(code_data1))
    code_data=code_data1;
    if errors~=0
        errors1=randperm(32);
        worrys=[];
        for n=1:errors
            worry=errors1(n);
            worrys(n)=worry;
            code_data1(1,worry)=~code_data1(1,worry);
        end
    else
        worrys=[];
        for n=1:length(errors11)
            worry=errors11(n);
            worrys(n)=worry;
            code_data1(1,worry)=~code_data1(1,worry);
        end
    end
    Tch_co_data=code_data1;
    
    %% 卷积解码
    len1=length(Tch_co_data);
    trellis = poly2trellis(K, CodeGenerator);
    decode_data = vitdec(Tch_co_data, trellis, len1/2,'trunc','hard');%维特比译码
    decodeBit=decode_data(1,1:length(decode_data)-6);
    set(d,'String',num2str(decodeBit))
    %% 统计误码数
    errorNum=sum(xor(dataBit,decodeBit));
    i=1;
    box=[];
    if errorNum==0
        for n=1:32
            different=xor(code_data(1,n),code_data1(1,n));
            if different==1
                box(i)=n;
                i=i+1;
            end
        end
        if length(box)~=0
            msgbox(['检查出第',num2str(box),'位出现错误，并成功纠错']);
            set(e,'String',num2str(box))
        else
            set(e,'String','未引入错误')
        end
    else
        msgbox('纠错失败，可能是错误位数过多或出错位置过于密集，请重试','警告')
        set(e,'String','纠错失败')
    end
    
    %% 过采样
     source_data_s=zeros(1,len_in*sample_num);
     code_data_s=zeros(1,len_out*sample_num);
     code_data_s1=zeros(1,len_out*sample_num);
     decode_data_s=zeros(1,len_in*sample_num);
     for n=1:len_in
          source_data_s(1,(n-1)*sample_num+1:n*sample_num)=dataBit(1,n);
          decode_data_s(1,(n-1)*sample_num+1:n*sample_num)=decodeBit(1,n);
     end
     for n=1:len_out
          code_data_s(1,(n-1)*sample_num+1:n*sample_num)=code_data(1,n);%正常编码
          code_data_s1(1,(n-1)*sample_num+1:n*sample_num)=code_data1(1,n);%错误编码
     end
    
    %% 打印波形
    figure("Name",'2','NumberTitle', 'off', 'Position', [50, 40, 700, 350])
    subplot(411)
    plot(t,source_data_s);
    xlabel('时间(s)');ylabel('幅值(v)');ylim([-1,2]);
    title('数据源')
    subplot(412)
    plot(t1,code_data_s);
    xlabel('时间(s)');ylabel('幅值(v)');ylim([-0.2,1.2]);
    title('卷积码编码后数据')
    subplot(413)
    plot(t1,code_data_s1);
    xlabel('时间(s)');ylabel('幅值(v)');ylim([-0.2,1.2]);
    title('卷积码编码出错数据')
    subplot(414)
    plot(t,decode_data_s);
    xlabel('时间(s)');ylabel('幅值(v)');ylim([-1,2]);
    title('卷积码解码数据')
end
end