`timescale 1ns/1ps

module test_DataRestore;
parameter NUM = 1280;
parameter PATH = "C:/Users/fire/Desktop/par2/sim/";
parameter PATH1 = "C:/Users/fire/Desktop/OFDM_802.11a_my/TX/matlab/test/";

reg             CLK = 0;
reg             Rst_n = 0;
reg             io_inputDataEn = 0;
reg     [7:0]   io_inputDataR = 0;
reg     [7:0]   io_inputDataI = 0;
reg     [7:0]   io_inputSymbol = 0;
reg             io_axisOut_ready = 0;
reg [1:0]       longmem[63:0];
reg [15:0]      datamem[NUM-1:0];

wire            io_axisOut_valid;
wire    [7:0]   io_axisOut_payload_data;
wire    [0:0]   io_axisOut_payload_last;
wire    [0:0]   io_axisOut_payload_user;

always #4 CLK = ~CLK;

initial begin
    #80;
    Rst_n = 1;
    io_axisOut_ready = 1;
    $readmemb({PATH,"long.txt"}, longmem);
    $readmemb({PATH1,"pilot_data_out.txt"}, datamem);
end

task automatic inputData;
    input [15:0] data;
    begin
        io_inputDataEn = 1;
        io_inputDataR = data[15:8];
        io_inputDataI = data[7:0];
        #8;
        io_inputDataEn = 0;
        #24;
        io_inputDataR = 0;
        io_inputDataI = 0;
    end
endtask

task automatic OPCNT;
    input [5:0]  num;
    integer i;
    integer j;
    begin
        for(i=0;i<num;i=i+1) begin
            for(j=0;j<64;j=j+1) begin
                inputData(datamem[(i<<6)+j]);
            end
            io_inputSymbol = i + 4;
            #120;
        end
    end
endtask

task automatic long;
    input [1:0] data;
    begin
        io_inputDataEn = 1;
        io_inputDataR[7:6] = data;
        io_inputDataR[5:0] = 0;
        io_inputDataI = 0;
        #8;
        io_inputDataEn = 0;
        #24;
        io_inputDataR = 0;
        io_inputDataI = 0;
    end
endtask
integer i;
initial begin
    wait(Rst_n);
    wait(!CLK);
    wait(CLK);
    #800;
    io_inputSymbol = 1;
    for(i=0;i<64;i=i+1) begin
        long(longmem[i]);
    end
    io_inputSymbol = 2;
    #120;
    for(i=0;i<64;i=i+1) begin
        long(longmem[i]);
    end
    io_inputSymbol = 3;
    #120;
    OPCNT(NUM/64);
    #800;
end

DataRestore DataRestore_u(
    .io_inputDataEn(io_inputDataEn),
    .io_inputDataR(io_inputDataR),
    .io_inputDataI(io_inputDataI),
    .io_inputSymbol(io_inputSymbol),
    .io_axisOut_valid(io_axisOut_valid),
    .io_axisOut_ready(io_axisOut_ready),
    .io_axisOut_payload_data(io_axisOut_payload_data),
    .io_axisOut_payload_last(io_axisOut_payload_last),
    .io_axisOut_payload_user(io_axisOut_payload_user),
    .Rst_n(Rst_n),
    .CLK(CLK)
);

endmodule