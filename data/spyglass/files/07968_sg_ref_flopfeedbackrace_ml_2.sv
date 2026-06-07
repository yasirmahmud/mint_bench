module flop_feedback_race_ex2 (input d_in, input rst_n, output reg q_out);
 wire clk_feedback;
 assign clk_feedback = q_out;
 always @(posedge clk_feedback or negedge rst_n) begin if (!rst_n) begin q_out <= 1'b0;
 end else begin q_out <= d_in;
 end endmodule
