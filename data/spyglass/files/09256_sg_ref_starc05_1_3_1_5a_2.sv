module module_ex2(input clk, input rst, output reg q);
 // synopsys sync_set_reset "q" always @(posedge clk) begin if (rst) q <= 1'b0; else q <= 1'b1; end endmodule
