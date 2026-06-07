module example_7 (
  output reg [0:0] enable
);
  // Original 'initial' block was ignored by synthesis (SYNTH_5143 violation).
  // Replaced with an 'always_comb' block to continuously assign 'enable' to 1'b0.
  // This ensures 'enable' is always 0 in a synthesizable manner, preserving the functional behavior
  // as implied by the initial assignment and retaining the 'reg' type for the output.
  always_comb begin
    enable = 1'b0;
  end
endmodule
