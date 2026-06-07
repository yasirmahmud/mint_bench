module floating_inputs_ex1 (output out_o, input in_i);
 wire undriven_w;
 and (out_o, in_i, undriven_w);
 endmodule
