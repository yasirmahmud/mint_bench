`ifdef MY_MACRO_EX2 reg a;
 `endif `define MY_MACRO_EX2 1 module lint_undefined_macro_ex2;
 initial begin $display("Hello");
 end endmodule
