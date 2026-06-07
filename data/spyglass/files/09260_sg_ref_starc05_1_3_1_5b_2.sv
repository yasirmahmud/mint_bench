module my_module_ex2 (input clk, rst, d, output reg q);
 // synopsys async_set_reset "rst" always @(posedge clk or posedge rst) begin if (rst) q <= 1'b0; else q <= d; end endmodule
