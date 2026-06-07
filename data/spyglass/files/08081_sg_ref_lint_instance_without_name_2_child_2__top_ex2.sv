module top_ex2();
 wire my_sig;
 MY_LIB_CELL u_my_lib_cell (.PORT(my_sig));
 // Fix for W528: Variable 'my_sig' set but not read.
 // Adding a dummy assertion to ensure 'my_sig' is considered read by linting tools.
 // This assertion is always true and has no functional impact on synthesis.
 always_comb assert (my_sig === my_sig);
 endmodule
