module my_module_ex2 (input clk, rst, d, output reg q);
 // synopsys async_set_reset "rst" always @(posedge clk or posedge rst) begin if (rst) begin q <= 1'b0; end else begin q <= d; end end endmodule
