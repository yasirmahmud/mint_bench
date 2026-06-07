module shift_latch_ex2 (input clk, input [31:0] data_in, output [31:0] data_out);
 reg [31:0] latch_q1;
 reg [31:0] latch_q2;
 always @(clk or data_in) if (clk) latch_q1 <= data_in;
 always @(clk or latch_q1) if (clk) latch_q2 <= latch_q1;
 assign data_out = latch_q2;
 endmodule
