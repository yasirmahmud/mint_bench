module reentrant_output_ex1_top;
 wire internal_signal;
 sub_module u_sub (.in_a(internal_signal), .out_b(internal_signal));
 endmodule
