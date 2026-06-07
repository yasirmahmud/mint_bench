module curve_synth_5230_20260111_225300_733392_w49296_attempt12 (
  output reg [7:0]  out_data
);

  integer i; // Loop counter, declared as integer to avoid W480 from previous attempt.

  // This always_comb block is synthesizable.
  // The 'for' loop within this block is the target for SYNTH_5230.
  always @* begin
    // SYNTH_5230: Number of iterations in for-loop exceeds max. allowable limit (2048).
    // This loop iterates 2049 times (i from 0 to 2048), triggering the violation.
    // The loop body is deliberately left empty. This is crucial to avoid
    // other SpyGlass violations, particularly W415a (multiple assignments)
    // or complex synthesis issues that might lead to additional warnings/errors.
    for (i = 0; i < 2049; i = i + 1) begin
      // Empty loop body
    end

    // Assign a default value to the output to prevent latches (if not all paths assign)
    // and to ensure 'out_data' is used, avoiding unused signal warnings.
    out_data = 8'h00; 
  end

endmodule
