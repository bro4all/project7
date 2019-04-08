`timescale 1ns / 1ps

module CU_tb;

reg CLK_tb, Go_tb, Start_tb;
reg [2:0] Op_tb;
wire [3:0] CS;
wire [1:0] Sel1_tb, c_tb;
wire [1:0] WA_tb, RAA_tb, RAB_tb;
wire WE_tb, REA_tb, REB_tb, Sel2_tb, Done_tb;

integer operation;

parameter
IDLE  = 14'b01_0_00_0_00_0_00_00_0,
R1 = 14'b11_0_00_0_00_1_01_00_0,
R2 = 14'b10_0_00_0_00_1_10_00_0;

parameter
ADD   = 14'b00_1_01_1_10_1_11_00_0,
SUB   = 14'b00_1_01_1_10_1_11_01_0,
AND   = 14'b00_1_01_1_10_1_11_10_0,
XOR   = 14'b00_1_01_1_10_1_11_11_0;

parameter
Done = 14'b01_1_11_1_11_0_00_10_1;

task tick;
begin
CLK_tb = 1; #5;
CLK_tb = 0; #5;
end
endtask

CU DUT0(.start(Start_tb), .Go(Go_tb), .CLK(CLK_tb), .Op(Op_tb), .CS(CS), .Done(Done_tb), .Sel1(Sel1_tb), .WA(WA_tb), .RAA(RAA_tb), .RAB(RAB_tb), .C(c_tb), .WE(WE_tb), .REA(REA_tb), .REB(REB_tb), .Sel2(Sel2_tb));

initial begin

$display("Testing Starting");

for(operation = 0; operation < 4; operation = operation + 1)
begin

Start_tb = 1;

tick;

Start_tb = 0;

tick;

Go_tb = 0;
Op_tb = operation;

tick;
tick;//S0

Go_tb = 1;
Tick; //S1

Go_tb = 0;

Tick; //S2

Tick; //S3

Tick; //S4

Tick; //S0
end

$display("Simulation Successful");
$finish;
end
endmodule
