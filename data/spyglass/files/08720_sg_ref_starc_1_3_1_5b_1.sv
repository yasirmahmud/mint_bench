module st_1_3_1_5b_ex1 (input clk, rst_n, d, output reg q);
 // synopsys async_set_reset "rst_n" always @(posedge clk or negedge rst_n) begin if (!rst_n) begin q <= 1'b0; end else begin q <= d; end end endmodule
