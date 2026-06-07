module curve_synth_5230_20260111_092751_attempt6 (
  input wire        dummy_in,
  output reg [1:0]  out_val
);

  // Declare an integer for the loop counter.
  integer count;

  always @* begin
    count = 0; // Initialize loop counter
    // The while-loop iterates exactly 2049 times (count from 0 to 2048).
    // This number of iterations explicitly exceeds the default SpyGlass loop limit (2048),
    // thereby triggering the SYNTH_5230 violation. The error will point to this line.
    while (count < 2049) begin
      count = count + 1; // Increment counter
      // Minimal loop body to avoid triggering other rules.
    end

    // Assign a simple value to the output after the loop.
    // 'out_val' is assigned exactly once in this always block.
    // 'dummy_in' is used to prevent potential unused input warnings.
    out_val = dummy_in ? 2'b10 : 2'b01;
  end

endmodule
