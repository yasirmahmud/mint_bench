module LINT_UNDEFINED_MACRO_USED_ex1;
 `ifdef MY_MACRO_A wire a;
 `endif `define MY_MACRO_A endmodule
