module curve_synth_5290_20260112_012517_094977_w37744_attempt18 (
  input wire [7:0] in_data,
  output wire [7:0] out_data
);

  // Declare a real parameter. Real parameters are allowed in Verilog-2001.
  // This declaration itself is not a violation.
  parameter real SCALING_FACTOR = 1.5;

  // SYNTH_5290 violation:
  // The expression 'in_data * SCALING_FACTOR' involves a real number (SCALING_FACTOR)
  // and an integer (in_data), which promotes the entire expression's result to a real number.
  // Assigning this real result to a synthesizable bit-vector 'out_data' is not synthesizable.
  // Synthesis tools cannot convert a real value into discrete hardware logic for direct assignment to a bit-vector.
  assign out_data = in_data * SCALING_FACTOR;

endmodule
