module top_mod_ex2;
 wire dummy_out_b; // Added to resolve W287b
 sub_mod inst_sub(.in_a(1'b0), .out_b(dummy_out_b)); // Connected out_b to dummy_out_b
 defparam inst_sub.P_WIDTH = 16;
 endmodule
