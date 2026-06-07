module curve_synth_5290_20260111_024903_attempt4 (
  input wire in_a,
  output wire out_b
);

  // Declare 'real' variables. These are inherently non-synthesizable types
  // when intended for hardware implementation.
  real r_val1;
  real r_val2;

  // Use 'real' variables in an always_comb block, which is a synthesizable context.
  // Any operation involving 'real' types within such a block is considered non-synthesizable
  // and triggers the SYNTH_5290 violation.
  always_comb begin
    // Assigning values to 'real' variables. Even with constant values, the presence
    // and manipulation of 'real' types here are problematic for synthesis.
    r_val1 = 12.34;
    r_val2 = 56.78;

    // A comparison between 'real' variables. This operation is not synthesizable.
    if (r_val1 < r_val2) begin
      out_b = in_a; // 'in_a' is used to avoid an unused input warning.
    end else begin
      out_b = 1'b0;
    end
  end

endmodule
