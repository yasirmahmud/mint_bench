module curve_synth_5230_20260111_225300_733392_w49296_attempt11 (
  output reg [7:0]  out_data
);

  reg [11:0] i; // Loop counter, needs 12 bits to hold up to 2048
  reg [7:0]  local_init_val; // A local register to ensure output and internal signals are used

  initial begin
    local_init_val = 8'hAB; // Initialize with a dummy value

    // SYNTH_5230: Number of iterations in for-loop exceeds max. allowable limit (2048).
    // This loop iterates 2049 times (i from 0 to 2048), triggering the violation.
    for (i = 0; i < 2049; i = i + 1) begin
      // The loop body is deliberately left empty. This is crucial to avoid
      // other SpyGlass violations, particularly W415a (multiple assignments)
      // or complex synthesis issues that might lead to additional warnings/errors.
    end

    out_data = local_init_val; // Assign the initialized value to the output to avoid unused signal warnings
  end

endmodule
