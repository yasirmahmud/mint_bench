module curve_synth_126_20260112_012521_052528_w47152_attempt13 (
    input clk,
    output [7:0] data_out
);

  // Declare a single-bit wire that will be driven by a continuous assign.
  wire single_bit_flag;

  // The original 'always' block contained a procedural continuous assign statement,
  // which caused the SYNTH_126 violation. Procedural continuous assigns are not synthesizable.
  // To resolve this, the 'assign' statement has been moved out of the 'always' block
  // to become a standard continuous assign. This correctly synthesizes 'single_bit_flag'
  // as a constant '1'b1', preserving the intended functional behavior.
  assign single_bit_flag = 1'b1;

  // Connect the assigned wire to the output.
  assign data_out[0] = single_bit_flag;
  // Drive the rest of the output bits to avoid undriven nets or partial driving warnings.
  assign data_out[7:1] = 7'b0;

endmodule
