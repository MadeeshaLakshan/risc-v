module alu(
    input logic [31:0] bus_a,bus_b,
    input logic [2:0] alu_sel,
    output logic [31:0] bus_c,
    output logic zero
);
always_comb
unique case(alu_sel)
3'b010: bus_c = bus_a + bus_b;
3'b110: bus_c = bus_a - bus_b;
3'b000: bus_c = bus_a & bus_b;
3'b001: bus_c = bus_a ^ bus_b;
default: bus_c= bus_a;
endcase

assign zero= (bus_c==0)? 1: 0;    
endmodule