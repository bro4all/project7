`timescale 1ns / 1ps

module ALU (
input [2:0] in1, in2,
input [1:0] c,
output reg [2:0] aluout
);

always @ (in1, in2, c)
begin 
    case (c)
            2'b00:  aluout = in1 + in2;
            2'b01:  aluout = in1 - in2;
            2'b10:  aluout = in1 & in2;
            default: aluout = in1 ^ in2; // 2'b11;
     endcase
end
 endmodule //ALU
