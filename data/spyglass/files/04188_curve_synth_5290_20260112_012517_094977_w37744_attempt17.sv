module curve_synth_5290_20260112_012517_094977_w37744_attempt17 (
  output wire [7:0] data_out
);

  // Declare a 'real' variable. In Verilog-2001, 'real' types are not synthesizable.
  // This declaration itself is legal for simulation, and does not cause SYNTH_89
  // as there is no initial assignment at declaration.
  real real_value_source;

  // Assign a real literal to the real variable using a continuous assignment.
  // This operation is typically ignored or handled by simulation tools.
  assign real_value_source = 123.456;

  // SYNTH_5290 violation: Attempting to assign a 'real' type to a synthesizable
  // bit-vector 'wire'. Synthesis tools cannot convert 'real' numbers into
  // discrete hardware logic for direct assignment to bit-vectors.
  assign data_out = real_value_source;

endmodule
