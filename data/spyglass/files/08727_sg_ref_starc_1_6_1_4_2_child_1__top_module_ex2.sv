module top_module_ex2 (output my_clk); // Added my_clk to output port list to resolve W528 (variable set but not read).
                                      // 'my_clk' is implicitly declared as 'output wire' by this declaration.
 intermediate_module_ex2 im_inst (.clk_i(my_clk));
endmodule
