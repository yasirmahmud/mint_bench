module curve_synth_5290_20260111_024903_attempt9 (
  input wire [7:0] input_value,
  output wire output_flag
);

  // Declare a real parameter, which is not synthesizable when used in logic.
  parameter real THRESHOLD_VAL = 123.45; // This declaration itself is generally fine.

  // Using the real parameter in a comparison within a continuous assignment
  // triggers SYNTH_5290 because 'real' types cannot be implemented in hardware.
  assign output_flag = (input_value > THRESHOLD_VAL) ? 1'b1 : 1'b0;

endmodule
