module unreachable_rst_ex1 (input clk, input d, input rst_n, output reg q);
 always @(posedge clk) begin q <= d;
 end endmodule
