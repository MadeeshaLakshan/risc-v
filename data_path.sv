module data_path(
    //control signal
    input  logic         clk,reset,
    input  logic [1:0]   memtoreg,
    input  logic         pcsrc,alusrc,
    input  logic         regwrite,
    input  logic [1:0]   immsrc,
    input  logic [2:0]   alucontrol,
    output logic         zero,
    //datapath io
    output logic [31:0]  pc,
    input  logic [31:0]  instr,
    output logic [31:0]  aluresult,writedata,
    input  logic [31:0]  readdata
);

//internal signals
logic [4:0] writereg;
logic [31:0] pcnext,pcplus4,pcbranch;
logic [31:0] immextd;
logic [31:0] scra,scrb;
logic [31:0] result;

//assign writedata=scrb;

//reg file
regfile reigster(
    .clk (clk)          ,
    .we  (regwrite)     ,
    .ra1 (instr[19:15]) ,
    .ra2 (instr[24:20]) ,
    .wa  (instr[11:7])  ,
    .wd  (result)       ,
    .rd1 (scra)         ,
    .rd2 (scrb)         
);

//immediate 
immext immextnd(
    .instr  (instr[31:0]),
    .immsrc (immsrc),
    .extimm(immextd)
);

//alu 
mux2 #(32) mux2(.d0(scrb),.d1(immextd),.s(alusrc),.y(writedata));
alu alu(
    .bus_a(scra),
    .bus_b(writedata),
    .alu_sel(alucontrol),
    .bus_c(aluresult),
    .zero(zero)
);
mux3 #(32) mux3(.d0(aluresult),.d1(readdata),.d2(pcplus4),.s(memtoreg),.y(result));


//pc
flopr #(32) pcreg(.clk(clk),.reset(reset),.d(pcnext),.q(pc));
addr pcadd4(.a(pc),.b(32'd4),.out(pcplus4));
addr pcaddbranch(.a(pc),.b(immextd),.out(pcbranch));
mux2 #(32)pcmux(.d0(pcplus4),.d1(pcbranch),.s(pcsrc),.y(pcnext));

endmodule


