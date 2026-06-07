module top_module_ex1 ();
 wire unused_out_port; // Declare a wire to connect the output port
 sub_module inst_sub (.in_port(1'b0), .out_port(unused_out_port));
 endmodule
