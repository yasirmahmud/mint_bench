module top_ex1;
 wire violating_net;
 wire output_net;
 master_mod u_master (.in_port(violating_net), .out_port(output_net));
 assign violating_net = 1'b0;
 endmodule
