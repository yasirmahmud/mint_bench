module w442a_ex1 (input clk, input rst_n, input d, output reg q);
 always @(posedge clk or negedge rst_n) begin q <= d;
 if (!rst_n) begin q <= 1'b0;
 end else begin end end endmodule
