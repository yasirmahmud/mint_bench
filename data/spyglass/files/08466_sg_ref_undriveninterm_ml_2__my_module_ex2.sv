module my_module_ex2 ();
 wire undriven_net;
 wire output_net;
 sub_module u_sub (.in_a (undriven_net), .out_z (output_net));
 endmodule
