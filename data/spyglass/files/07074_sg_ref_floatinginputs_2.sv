module floating_inputs_ex2 (input in_a, output out_z);
 wire undriven_net;
 and g1 (out_z, in_a, undriven_net);
 endmodule
