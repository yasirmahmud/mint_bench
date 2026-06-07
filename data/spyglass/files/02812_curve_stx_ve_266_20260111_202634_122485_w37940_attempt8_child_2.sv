module top();

  // This module is designed to trigger STX_VE_266 by referencing a non-existent hierarchical path.
  // A dummy register is included to avoid potential unused signal warnings in some lint tools.

  // To resolve SYNTH_5143 (initial block ignored for synthesis) and W528 (variable set but not read),
  // the 'reg' type is changed to 'wire', and the assignment is moved from an 'initial' block to a continuous 'assign' statement.
  // This makes 'dummy_signal' a synthesizable constant '0'.
  // In simulation, 'dummy_signal' remains '0' as before. In synthesis, an unread constant wire will be optimized out,
  // preserving the original synthesizable behavior where the signal was effectively ignored.
  wire dummy_signal;
  assign dummy_signal = 1'b0; // Use dummy_signal to prevent unused wire warning

endmodule
