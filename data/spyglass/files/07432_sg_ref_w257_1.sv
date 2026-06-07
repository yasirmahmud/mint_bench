module delay_w257_ex1 (input clk, input d, output reg q);
 always @(posedge clk) begin #1 q <= d;
 end endmodule
