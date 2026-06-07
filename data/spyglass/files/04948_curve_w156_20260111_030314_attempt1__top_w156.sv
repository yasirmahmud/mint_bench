module top_w156 (
  output wire [3:0] top_out
);
  // Declare a wire with a standard MSB:LSB range
  wire [3:0] my_bus_sig;
  wire [3:0] sub_output_sig;

  // Assign a value to avoid unused signal warning for 'my_bus_sig'
  assign my_bus_sig = 4'b1100; 

  // Instantiate sub_w156.
  // The 'data_in' port in 'sub_w156' is declared as [3:0].
  // Connecting it to 'my_bus_sig[0:3]' (reversed bit order) will trigger W156.
  // For example, if my_bus_sig = {A,B,C,D} where A is MSB, D is LSB.
  // my_bus_sig[0:3] evaluates to {D,C,B,A}.
  // When connected to data_in[3:0], data_in[3] gets D, data_in[2] gets C, etc.
  // This reverses the bit order of the bus connection relative to the port definition.
  sub_w156 u_sub_w156 (
    .data_in  (my_bus_sig[0:3]), // Target line for W156: Bus net 'data_in' is connected in reverse.
    .data_out (sub_output_sig)
  );

  // Drive an output to avoid unused signal warning for 'sub_output_sig'
  assign top_out = sub_output_sig;

endmodule
