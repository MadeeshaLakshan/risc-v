module data_path_tb;
    logic clk=0,reset;
    logic [1:0]   memtoreg;
    logic         pcsrc,alusrc;
    logic         regwrite;
    logic [1:0]   immsrc;
    logic [2:0]   alucontrol;
    logic         zero;
    //datapath io
    logic [31:0]  pc;
    logic [31:0]  instr;
    logic [31:0]  aluresult,writedata;
    logic [31:0]  readdata;


    data_path dut(.*);
    
    localparam CLK_PERIOD = 10;
    initial forever
    #(CLK_PERIOD/2) clk <= ~clk;

    initial begin
    #(CLK_PERIOD);
    %@(posedge clk) #1; reset<=1;
    @(posedge clk) #1; reset<=0; pcsrc<=0; 
    @(posedge clk) #1 memtoreg<=0;instr <= 32'he800093;regwrite<='b1; immsrc<='b0;alusrc<='b1;alucontrol<='b010;
    @(posedge clk) #1; instr <= 32'h3e800113;regwrite<='b1; immsrc<='b0;alusrc<='b1;alucontrol<='b010;
    @(posedge clk) #1; instr <= 32'h001101b3;regwrite<='b1; ;alusrc<='b0;alucontrol<='b010;
    @(posedge clk) #1; instr <= 32'h40110233;regwrite<='b1; ;alusrc<='b0;alucontrol<='b110;
    
    end

endmodule