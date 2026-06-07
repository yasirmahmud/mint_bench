module test7(input clk, input rst);
  reg control_reg;
  assign control_reg = clk & rst;
endmodule
