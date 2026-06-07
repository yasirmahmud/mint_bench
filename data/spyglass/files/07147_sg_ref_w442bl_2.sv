module complex_reset_ex2 (input clk, input reset_a, input reset_b, input d, output reg q);
 always @(posedge clk or posedge reset_a or posedge reset_b) begin if (reset_a && reset_b) begin q <= 1'b0;
 end else begin q <= d;
 end end endmodule
