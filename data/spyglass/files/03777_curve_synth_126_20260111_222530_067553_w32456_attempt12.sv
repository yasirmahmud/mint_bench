module curve_synth_126_20260111_222530_067553_w32456_attempt12 (
  input a,
  input b,
  output out_val
);

  reg internal_result; // Declared as reg to be assigned procedurally

  // Placing a continuous 'assign' statement inside an 'always @*' block
  // makes it a procedural continuous assign, which triggers SYNTH_126.
  always @* begin
    assign internal_result = a | b; // This line triggers SYNTH_126
  end

  // Use internal_result to ensure it's not optimized away and connects to an output.
  assign out_val = internal_result;

endmodule
