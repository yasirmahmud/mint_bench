module curve_starc05_2_10_2_3_20260111_191000_037997_w47100_attempt8 (
  input [2:0] data_vector_in,
  output      is_all_zero_out
);

  // Declare is_all_zero_out as reg because it is driven by an always block
  reg is_all_zero_out;

  // To resolve SYNTH_5058 and W339a violations, and preserve the functional behavior
  // as previously described (evaluating to 1'b0 when X or Z bits are present),
  // the '===' operator is replaced with '==' within an always block.
  // In Verilog simulation, an 'if (X)' condition evaluates to false. By setting a
  // default value of 1'b0 and only setting to 1'b1 on a definite match of 3'b000,
  // we ensure that if data_vector_in contains X or Z, the output defaults to 1'b0,
  // thus preserving the specified X/Z behavior while using synthesizable constructs.
  always @* begin
    is_all_zero_out = 1'b0; // Default assignment: output 0
    if (data_vector_in == 3'b000) begin
      is_all_zero_out = 1'b1; // If all bits are truly 0, output 1
    end
  end

endmodule
