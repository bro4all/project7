`timescale 1ns / 1ps

module DP_tb();

reg [2:0] in1_tb, in2_tb;
reg [1:0] s1_tb, wa_tb, raa_tb, rab_tb, c_tb;
reg we_tb, rea_tb, reb_tb, s2_tb, clk_tb;
wire [2:0] out_tb;

DP CA(.in1(in1_tb), .in2(in2_tb), .s1(s1_tb), .wa(wa_tb), .raa(raa_tb), .rab(rab_tb), .c(c_tb), .we(we_tb), .rea(rea_tb), .reb(reb_tb), .s2(s2_tb), .clk(clk_tb), .out(out_tb));

integer control, expected_out;

//Generate Clock
task tick;
begin
    #1 clk_tb = 1;
    #1 clk_tb = 0;
end
endtask

initial 
    begin
$display("Testing Starting");

clk_tb = 0;
we_tb = 1;
s2_tb = 1;
rea_tb = 0;
reb_tb = 0;

#2 

 in1_tb = $random;
 wa_tb = 2'b01; //writing to address 1
 s1_tb = 2'b11; //selecting input 1

     tick;
     
    in2_tb = 3'b001;
    wa_tb = 2'b10; //writing to address 2
    s1_tb = 2'b10; //selecting input 2

    tick;

for(control = 0; control <4; control = control + 1)
begin

rab_tb = 2'b10;
raa_tb = 2'b01;

rea_tb = 1;
reb_tb = 1;

c_tb = control;

#2
        case(c_tb)
     2'b00: begin 
                if(out_tb != in1_tb + in2_tb) $display("Error at addition %d + %d != %d", in1_tb, in2_tb, out_tb );
                else $display("%d + %d = %d", in1_tb, in2_tb, out_tb);
            end
     2'b01: begin
                if(out_tb != in1_tb - in2_tb) $display("Error at subtraction, %d - %d != %d", in1_tb, in2_tb, out_tb);
                else $display("%d - %d = %d", in1_tb, in2_tb, out_tb);
             end
    2'b10: begin
                expected_out = in1_tb & in2_tb;
                if(out_tb != expected_out[2:0]) $display("Error at AND, %d & %d != %d", in1_tb, in2_tb, out_tb);
                else $display("%d & %d = %d", in1_tb, in2_tb, out_tb);
           end
   default: begin
              expected_out = in1_tb ^ in2_tb;
              if(out_tb != expected_out[2:0]) $display("Error at default, %d ^ %d != %d", in1_tb, in2_tb, out_tb);
              else $display("%d ^ %d = %d", in1_tb, in2_tb, out_tb);
            end
        endcase
end  

//testing s1 = 0

expected_out = out_tb;
$display("Value looping = %d", expected_out[2:0]);

wa_tb = 2'b01; //writing to address 1
s1_tb = 2'b00; //input that loops back

tick;

rab_tb = 2'b01; 
raa_tb = 2'b01; 

rea_tb = 1;
reb_tb = 1;

c_tb = 2'b10;

#2;

if(out_tb != expected_out[2:0]) $display("Error when s1 = 0");
else $display("Out_tb = %d", out_tb);

#2;

//testing mux2 when input is zero
s2_tb = 0;
#2;

if(out_tb != 0) $display("Mux2 not working for in2 , out_tb = %d", out_tb);
else $display("out_tb = 0 when S2 = 0");



$display("Testing Ended");

end
endmodule
