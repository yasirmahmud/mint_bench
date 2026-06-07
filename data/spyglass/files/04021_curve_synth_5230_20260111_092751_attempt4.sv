module curve_synth_5230_20260111_092751_attempt4 (
  input wire        dummy_in, // Input to avoid unused input warning
  output reg [11:0] out_val
);

  // Declare an integer for the loop counter.
  integer i;
  // Declare a register to accumulate a value.
  // Using 12-bit to accommodate values up to 2049.
  reg [11:0] accumulator;

  always @* begin
    accumulator = 12'd0; // Initialize for combinational logic

    // The for-loop iterates exactly 2049 times (i from 0 to 2048).
    // This number of iterations explicitly exceeds the default SpyGlass loop limit (2048),
    // thereby triggering the SYNTH_5230 violation. The error will point to this line.
    for (i = 0; i < 2049; i = i + 1) begin
      // Perform a minimal operation to ensure the loop is active and synthesizable.
      accumulator = accumulator + 1;
    end

    // Assign the final accumulated value to the output.
    // Use dummy_in to prevent potential unused input warning (e.g., W245).
    out_val = accumulator + (dummy_in ? 12'd1 : 12'd0);
  end

endmodule
