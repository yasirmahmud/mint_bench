module top_module_ex1;
 wire unused_u1_out_port; // Connect the unconnected output port to an unused wire
 sub_module u1 (.in_port(1'b0), .out_port(unused_u1_out_port));
 endmodule
