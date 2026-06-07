module w316_ex1();
 integer int_var;
 reg [7:0] narrow_reg;
 initial begin narrow_reg = 8'hFF;
 int_var = narrow_reg;
 end endmodule
