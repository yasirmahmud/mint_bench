module curve_synth_5230_20260111_092751_attempt1();

  integer i;

  initial begin
    // This for-loop iterates 2049 times (i from 0 to 2048).
    // This number of iterations exceeds the default SpyGlass limit of 2048
    // for for-loops, triggering SYNTH_5230.
    for (i = 0; i < 2049; i = i + 1) begin
      // Minimal operation to keep the loop active
      // No actual logic needed to trigger the rule
    end
  end

endmodule
