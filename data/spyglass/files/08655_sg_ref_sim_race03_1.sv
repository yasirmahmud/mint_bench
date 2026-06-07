module sim_race03_ex1 (input clk, input d_in, output reg q_out);
 always @(posedge clk) begin q_out = d_in;
 end endmodule
