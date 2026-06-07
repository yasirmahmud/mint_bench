module sync_reset_ex2 (out_q, clk, rst, din);
 input clk, rst, din;
 output out_q;
 reg out_q;
 always @ (posedge clk) begin if (rst) out_q = 1'b0;
 else out_q = din;
 end endmodule
