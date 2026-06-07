module st_1_3_1_5a_ex1 (input clk, rst, d, output reg q);
 // synopsys sync_set_reset "rst" always @(posedge clk) if (rst) q <= 1'b0; else q <= d; endmodule
