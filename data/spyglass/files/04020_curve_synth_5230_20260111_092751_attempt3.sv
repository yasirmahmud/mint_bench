module curve_synth_5230_20260111_092751_attempt3 (
  input wire        dummy_in, // Input to avoid unused input warning
  output reg [11:0] out_val
);

  // Declare an integer for the loop counter.
  integer current_iter;
  // Declare a register to accumulate a value.
  // Using 12-bit to accommodate values up to 2048.
  reg [11:0] accumulator;

  always @* begin
    accumulator = 12'd0; // Initialize for combinational logic
    current_iter = 0;   // Initialize loop counter

    // The while-loop iterates 2049 times (from current_iter = 0 to 2048).
    // This number of iterations explicitly exceeds the default SpyGlass loop limit (2048),
    // thereby triggering the SYNTH_5230 violation. The error will point to this line.
    while (current_iter < 2049) begin
      // Perform a minimal operation to ensure the loop is active and synthesizable.
      // This assignment to 'accumulator' within the while loop is similar to the
      // 'divider4bit' example's assignment to 'remainder', which did not trigger W415a.
      accumulator = accumulator + 1;
      current_iter = current_iter + 1;
    end

    // Assign the final accumulated value to the output.
    // Use dummy_in to prevent potential unused input warning (e.g., W245).
    out_val = accumulator + (dummy_in ? 12'd1 : 12'd0);
  end

endmodule
