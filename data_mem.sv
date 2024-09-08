module data_mem(
    input  logic clk,we,
    input  logic [5:0] ad,
    input  logic [31:0] wd,
    output logic [31:0] rd
);

logic [31:0] mem[63:0];

always @(posedge clk)
    if(we) mem[ad] <= wd ;

assign rd = mem[ad];
    
endmodule