module curve_synth_5230_20260111_092751_attempt5 (
  input wire        dummy_in,
  output reg [1:0]  out_val
);

  // Declare an integer for the loop counter.
  integer i;

  always @* begin
    // The for-loop iterates exactly 2049 times (i from 0 to 2048).
    // This number of iterations explicitly exceeds the default SpyGlass loop limit (2048),
    // thereby triggering the SYNTH_5230 violation. The error will point to this line.
    for (i = 0; i < 2049; i = i + 1) begin
      // Empty loop body. This avoids multiple assignments to any 'reg' inside the loop,
      // which helps to prevent warnings like W415a that appeared in previous attempts.
    end

    // Assign a simple value to the output after the loop.
    // 'out_val' is assigned exactly once in this always block, ensuring no W415a for out_val.
    // 'dummy_in' is used to prevent potential unused input warnings (e.g., W245).
    out_val = dummy_in ? 2'b10 : 2'b01;
  end

endmodule
