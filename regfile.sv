module regfile(
    input  logic        clk, we,
    input  logic [4:0]  ra1,ra2,wa,
    input  logic [31:0] wd,
    output logic [31:0] rd1,rd2
);
//32 reigsters 
//two read adress ports and two read data ports
//one write adress and one write data
//

logic [31:0] regf[31:0];

always_ff @(posedge clk)
    if (we) regf[wa] <= wd;

assign rd1 = (ra1 !=0) ? regf[ra1] : 0;
assign rd2 = (ra2 !=0) ? regf[ra2] : 0;
    
endmodule