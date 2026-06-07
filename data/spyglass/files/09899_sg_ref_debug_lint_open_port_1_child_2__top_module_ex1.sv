module top_module_ex1;
 (* keep *) wire unused_u1_out_port; // Connect the unconnected output port to an unused wire and prevent optimization/warning
 sub_module u1 (.in_port(1'b0), .out_port(unused_u1_out_port));
 endmodule
