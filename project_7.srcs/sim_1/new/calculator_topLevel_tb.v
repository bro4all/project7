`timescale 1ns / 1ps

module calculator_topLevel_tb;

reg Go_tb, CLK_tb, start;
reg [1:0] Op_tb;
reg [2:0] In1_tb, In2_tb;
wire [3:0] CS_tb;
wire Done_tb;
wire [2:0] Out_tb;

integer operation, a, b;

//Generate Clock
task tick;
begin
#1 CLK_tb = 1;
#1 CLK_tb = 0;
end
endtask

calculator_fpga main(.start(start), .Go(Go_tb), .CLK(CLK_tb), .Op(Op_tb), .In1(In1_tb), .In2(In2_tb), .CS(CS_tb), .Done(Done_tb), .Out(Out_tb));

initial begin
$display("Testing Starting");

for(a = 0; a < 8; a = a+1)
begin

start = 0;
In1_tb = a;

for(b = 0; b < 8; b = b+1)
begin

In2_tb = b;

tick;

start =1;
tick;
start =0;
tick;

for(operation = 0; operation<=3; operation = operation +1)
begin

Go_tb = 0;
Op_tb = operation;

$display("State 0");

tick;
tick;

Go_tb = 1;
$display("State 1");

tick; //s1

Go_tb = 0;

$display("State 2");
tick;//s2

$display("State 3");
tick; //s3

$display("State 4");
tick; //s4

$display("State 0");
tick; //s0

end
end
end
end

endmodule
