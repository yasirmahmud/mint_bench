module top_module_ex2 (input top_in, output top_out);
 wire unused_sub_out_port;
 sub_module u_inst (.in_port(top_in), .out_port(unused_sub_out_port));
 assign top_out = 1'b0;
 endmodule
