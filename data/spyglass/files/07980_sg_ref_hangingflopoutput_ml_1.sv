module hanging_flop_ex1 (input clk, input rst_n, input d_in);
 reg q_flop;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) q_flop <= 1'b0;
 else q_flop <= d_in;
 end endmodule
