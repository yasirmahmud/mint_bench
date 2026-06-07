module w257_ex2(input clk, d, output reg q);
 always @(posedge clk) begin #5 q <= d;
 end endmodule
