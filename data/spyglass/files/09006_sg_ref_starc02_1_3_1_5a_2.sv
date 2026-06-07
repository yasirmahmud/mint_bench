module my_module_ex2 (input clk, rst, output reg q);
 // synopsys sync_set_reset "rst" always @(posedge clk) begin if (rst) q <= 1'b0; else q <= 1'b1; end endmodule
