`timescale 1ns / 1ps

module calculator_topLevel
(

input Go, CLK, start,
input [1:0] Op,
input [2:0] In1, In2,
output [3:0] CS,
output Done,
output [2:0] Out
 );
 
wire [1:0] s1, WA, RAA, RAB, c;
wire WE, REA, REB, s2;

CU U0(.start(start), .Go(Go), .CLK(CLK), .Op(Op), .CS(CS), .Sel1(s1), .WA(WA), .RAA(RAA), .RAB(RAB), .C(c), .WE(WE), .REA(REA), .REB(REB), .Sel2(s2), .Done(Done));
DP U1(.in1(In1), .in2(In2), .s1(s1), .wa(WA), .raa(RAA), .rab(RAB), .c(c), .we(WE), .rea(REA), .reb(REB), .s2(s2), .clk(CLK), .out(Out));

endmodule
