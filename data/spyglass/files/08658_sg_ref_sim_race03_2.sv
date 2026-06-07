module sim_race03_ex2 (input clk, input rst, input d_in, output reg q_ff);
 always @(posedge clk or posedge rst) begin if (rst) q_ff = 1'b0;
 else q_ff = d_in;
 end endmodule
