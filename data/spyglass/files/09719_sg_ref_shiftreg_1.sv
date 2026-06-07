module shiftreg_ex1(input clk);
 reg [25:0] r_shift;
 always @(posedge clk) begin r_shift[23:2] = r_shift[24:3];
 end endmodule
