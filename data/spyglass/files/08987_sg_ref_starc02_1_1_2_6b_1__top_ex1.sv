module top_ex1;
 wire some_net;
 wire out_wire;
 master_mod u_inst (.in_port(some_net), .out_port(out_wire));
 assign some_net = 1'b0;
 endmodule
