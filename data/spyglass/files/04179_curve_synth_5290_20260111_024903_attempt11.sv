module curve_synth_5290_20260111_024903_attempt11 (
  output wire [7:0] data_out
);

  // Declare a real parameter. In Verilog-2001, 'real' types are not synthesizable.
  parameter real CONSTANT_REAL_VALUE = 25.5;

  // Assigning a 'real' type (CONSTANT_REAL_VALUE) to a synthesizable 'wire'
  // directly triggers the SYNTH_5290 violation because the usage of 'real'
  // in hardware assignment is not synthesizable. Synthesis tools cannot represent
  // or convert real numbers into discrete hardware logic for assignment.
  assign data_out = CONSTANT_REAL_VALUE; // SYNTH_5290 violation expected here

endmodule
