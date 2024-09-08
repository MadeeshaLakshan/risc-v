module insruction_mem(
    input  logic [5:0] ad,
    output logic [31:0]ins
);
    logic [31:0] mem[63:0];

    initial 
    $readmemh("instructions.dat",mem);
    assign ins= mem[ad];
    
endmodule