module curve_synth_126_20260112_012521_052528_w47152_attempt13 (
    input clk,
    output [7:0] data_out
);

  // Declare a single-bit wire that will be driven by a procedural continuous assign.
  wire single_bit_flag;

  // This 'always' block contains a procedural continuous assign statement.
  // An 'assign' statement inside an 'always' or 'initial' block is not synthesizable
  // and triggers the SYNTH_126 violation.
  always @(posedge clk) begin
    // This line triggers SYNTH_126
    assign single_bit_flag = 1'b1;
  end

  // Connect the procedurally assigned wire to the output.
  assign data_out[0] = single_bit_flag;
  // Drive the rest of the output bits to avoid undriven nets or partial driving warnings.
  assign data_out[7:1] = 7'b0;

endmodule
