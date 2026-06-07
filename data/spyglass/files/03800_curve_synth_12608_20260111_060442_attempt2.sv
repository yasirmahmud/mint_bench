module curve_synth_12608_20260111_060442_attempt2 (
  input d,
  output reg q
);

  // This always_latch block is expected to trigger SYNTH_12608.
  // The rule appears to flag SystemVerilog's always_latch when the logic
  // within it is purely combinational, suggesting it should be always_comb.
  always_latch begin
    q = d;
  end

endmodule
