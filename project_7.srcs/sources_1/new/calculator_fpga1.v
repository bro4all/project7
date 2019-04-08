`timescale 1ns/ 1ps

module calculator_fpga1(
input button, Go, clk100MHz, RST,
input [2:0] in1, in2,
input [1:0] Op,
output Done,
output [7:0] LEDOUT,
output [7:0] LEDSEL
);

supply1[7:0] vcc;
wire button_debouncer, DONT_USE, clk_5KHz;

wire [7:0]out_led, cs_led;
wire [2:0] Out;
wire [3:0] CS;


clk_gen U0 (.clk100MHz(clk100MHz), .rst(RST),.clk_4sec(DONT_USE), .clk_5KHz(clk_5KHz));
button_debouncer U1(.button(button),.debounced_button(button_debouncer), .clk(clk_5KHz));
calculator_topLevel U2(.Go(Go), .CLK(button_debouncer), .start (RST), .Op (Op), .In1(in1), .In2(in2), .CS(CS), .Done(Done), .Out(Out));

bcd_to_7seg U3({0,Out[2:0]}, out_led);
bcd_to_7seg U4(CS, cs_led);

led_mux U5(clk_5KHz, RST, cs_led, vcc, vcc, vcc, vcc, vcc, vcc, out_led, LEDSEL, LEDOUT);

endmodule
