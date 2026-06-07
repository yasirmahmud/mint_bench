module lint_unspecified_macro_name_ex2 (input a, output b);
 wire c;
 assign c = a;
 `ifndef assign b = c;
 `else assign b = ~c;
 `endif endmodule
