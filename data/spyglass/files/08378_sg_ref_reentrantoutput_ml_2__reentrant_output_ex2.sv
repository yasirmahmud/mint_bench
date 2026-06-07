module reentrant_output_ex2();
 wire sig_a;
 my_sub_module u_inst (.in_port(sig_a), .out_port(sig_a));
 endmodule
