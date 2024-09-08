module immext(
    input logic [31:0] instr,
    input logic [1:0] immsrc,
    output logic [31:0] extimm
);

always_comb begin
    case(immsrc)

    2'b00 : extimm = {{21{instr[31]}},instr[30:20]};//I type
    2'b01 : extimm = {{21{instr[31]}},instr[30:25],instr[11:7]};//s
    2'b10 : extimm = {{21{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};//B
    2'b11 : extimm = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};//u
    default: extimm= 32'bx;

    endcase
end   
endmodule