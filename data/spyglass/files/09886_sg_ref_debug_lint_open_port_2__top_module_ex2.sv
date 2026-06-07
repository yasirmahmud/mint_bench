module top_module_ex2 (input top_in, output top_out);
 sub_module u_inst (.in_port(top_in), .out_port());
 assign top_out = 1'b0;
 endmodule
