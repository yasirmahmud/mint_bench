module W442bL_ex1 (input clk, input reset_n, input enable, input d, output reg q);
 always @(posedge clk or negedge reset_n) begin if (reset_n == 0 && enable) begin q <= 1'b0;
 end else begin q <= d;
 end end endmodule
