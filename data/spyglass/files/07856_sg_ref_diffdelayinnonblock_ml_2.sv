module diff_delay_in_non_block_ex2(input clk, input d);
 reg q1, q2;
 always @(posedge clk) begin q1 <= #1 d;
 q2 <= #2 q1;
 end endmodule
