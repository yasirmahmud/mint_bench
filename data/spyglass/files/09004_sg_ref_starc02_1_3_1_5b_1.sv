module STARC02_1_3_1_5b_ex1();
 // synopsys async_set_reset "rst"; reg clk, rst, q; always @(posedge clk or posedge rst) begin if (rst) q <= 1'b0; else q <= ~q; end endmodule
