module curve_starc05_2_4_1_5_20260111_230307_578409_w49296_attempt12 (
  input             input_data,
  input             enable_sig,
  output reg        output_data_out
);

  reg               stage1_latch_data;
  reg               stage2_latch_data;

  // Latch 1: This block infers a latch for 'stage1_latch_data'.
  // It is enabled by 'enable_sig'.
  always_latch begin
    if (enable_sig) begin
      stage1_latch_data = input_data;
    end
    // The missing 'else' branch infers a latch.
  end

  // Latch 2: This block infers a latch for 'stage2_latch_data'.
  // It is also enabled by 'enable_sig', which is the SAME phase enable as Latch 1.
  // Its input is 'stage1_latch_data', which is the output of Latch 1.
  // This directly creates a two-level latch chain where both levels share the same enable signal,
  // triggering the STARC05-2.4.1.5 violation.
  always_latch begin
    if (enable_sig) begin
      stage2_latch_data = stage1_latch_data; // This is the assignment that uses the first level latch output
    end
    // The missing 'else' branch infers a latch.
  end

  // Connect to an output to avoid unused signal warnings/violations.
  assign output_data_out = stage2_latch_data;

endmodule
