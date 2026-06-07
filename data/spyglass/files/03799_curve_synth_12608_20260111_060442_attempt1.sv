module curve_synth_12608_20260111_060442_attempt1 (
  output reg q
);

  // This always_latch block is expected to trigger SYNTH_12608
  // as the rule appears to disallow the use of SystemVerilog's always_latch construct.
  always_latch begin
    q = 1'b0;
  end

endmodule
