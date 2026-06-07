module unused_macro_ex2;
 `define MY_UNUSED_MACRO_W34 1 // Define an unused macro
 reg dummy_reg;
 initial begin
  dummy_reg = 1'b0;
 end
endmodule
