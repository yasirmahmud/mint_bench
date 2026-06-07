module shift_reg_ex2(clk);
 input clk;
 reg [25:0] r_shift;
 always @(posedge clk) r_shift[23:2] = r_shift[24:3];
 endmodule
