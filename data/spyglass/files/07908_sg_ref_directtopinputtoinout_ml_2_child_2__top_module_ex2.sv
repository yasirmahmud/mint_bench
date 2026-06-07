module top_module_ex2 (input top_in, output top_out);
 sub_module inst_sub (.io_port(top_in));
 assign top_out = 1'b0;
 endmodule
