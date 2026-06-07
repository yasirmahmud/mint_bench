module async_reset_ex2(input clk, input d, output reg q);
 wire internal_rst_n;
 assign internal_rst_n = 1'b0;
 always @(posedge clk or negedge internal_rst_n) begin if (!internal_rst_n) q <= 1'b0;
 else q <= d;
 end endmodule
