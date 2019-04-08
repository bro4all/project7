`timescale 1ns / 1ps

module CU(
          input start, Go, input CLK,
          input [1:0] Op,
          output reg [3:0] CS,
          output reg Done,
          output reg[1:0] Sel1, WA, RAA, RAB, C,
          output reg WE, REA, REB, Sel2);

reg [13:0] CW;
reg [3:0] NS;


parameter
S0  = 4'b0000,
S1 = 4'b0001,
S2 = 4'b0010,
S3  = 4'b0011,
S4  = 4'b0100;


parameter
IDLE  = 14'b01_00_0_00_0_00_0_00_0,
R1 = 14'b11_01_1_00_0_01_0_00_0,
R2 = 14'b10_10_1_00_0_10_0_00_0,
WAIT = 14'b00_11_1_01_0_00_0_00_0;

parameter
ADD   = 14'b00_11_1_01_1_10_1_00_0,
SUB   = 14'b00_11_1_01_1_10_1_01_0,
AND   = 14'b00_11_1_01_1_10_1_10_0,
XOR   = 14'b00_11_1_01_1_10_1_11_0;

parameter
DONE  = 14'b01_00_0_11_1_11_1_10_1;

always @(CW) begin
 {Sel1, WA, WE, RAA, REA, RAB, REB, C, Sel2} = CW;
end

always@(CS, NS, Go, Op)
begin
        case(CS)
            S0: begin
                    if (Go) begin 
                    CW = R1;
                    NS = S1;
                    end
                    
                    else begin
                    CW = IDLE;
                    Done = 0;
                    NS = S0;
                    end 
                end
            S1: begin
                    CW = R2;
                    NS = S2;
                end
            S2: begin
                    CW = WAIT;
                    NS = S3;
                  
                end
            S3: begin
                    if (Op == 2'b11) CW = ADD;
                     else if (Op == 2'b10) CW = SUB;
                     else if (Op == 2'b01) CW = AND;
                      else CW = XOR;
                    
                     NS = S4;
                end
            S4: begin
                   CW = DONE;
                   Done = 1;
                    NS = S0;
            end
        default: NS = S0;
    endcase
end

always@(posedge CLK)
begin
if(start)
    CS <= S0;
 else
    CS <= NS;
end

endmodule
