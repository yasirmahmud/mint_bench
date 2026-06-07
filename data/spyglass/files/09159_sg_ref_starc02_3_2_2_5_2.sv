`define MY_MACRO1_ex2 1 `define MY_MACRO2_ex2 `MY_MACRO1_ex2 module nested_macro_ex2;
 parameter int P = `MY_MACRO2_ex2;
 endmodule
