module safe_latch_ml_ex2 (input wire clk_l1, input wire data_in, input wire clk_a, input wire clk_b, input wire clk_l3, output reg data_out);
 reg l1_q;
 reg l2_q;
 wire latch_enable;
 always @(posedge clk_l1) l1_q <= data_in;
 assign latch_enable = clk_a & clk_b;
 always @(latch_enable or l1_q) if (latch_enable) l2_q <= l1_q;
 always @(posedge clk_l3) data_out <= l2_q;
 endmodule
