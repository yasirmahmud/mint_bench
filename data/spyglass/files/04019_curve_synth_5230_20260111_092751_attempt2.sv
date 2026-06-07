module curve_synth_5230_20260111_092751_attempt2(
  input wire      dummy_in, // Input used to avoid 'unused input' warning
  output reg [7:0] out_val
);

  integer i;
  reg [7:0] internal_val;

  // This always block is synthesizable, unlike an initial block.
  // The for-loop within it will be considered for synthesis unrolling.
  always @* begin
    internal_val = 8'h00; // Initialize to prevent latch inference

    // The for-loop iterates 2049 times (i from 0 to 2048).
    // This number of iterations explicitly exceeds the default SpyGlass loop limit (2048),
    // thereby triggering the SYNTH_5230 violation.
    for (i = 0; i < 2049; i = i + 1) begin
      // Perform a minimal operation to ensure the loop is active and synthesizable.
      // This operation will be unrolled 2049 times, stressing the loop limit.
      internal_val = internal_val + 1;
    end

    // Use the input 'dummy_in' to avoid an 'unused input' warning (e.g., W245).
    out_val = internal_val + (dummy_in ? 8'd1 : 8'd0);
  end

endmodule
