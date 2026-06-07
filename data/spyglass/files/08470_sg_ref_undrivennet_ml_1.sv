module undriven_net_ex1 (input in_a, output out_z);
 wire undriven_wire;
 assign out_z = undriven_wire & in_a;
 endmodule
