module UndrivenClockAssert2(
  input wire sys_clk // Make the clock an input to resolve PRP_NO_DRVC
);
  wire my_undriven_clock = sys_clk; // Drive the original signal with the input clock

`ifndef SYNTHESIS
  property p_always_true;
    @(posedge my_undriven_clock) 1'b1;
  endproperty

  // my_undriven_clock is now driven, resolving PRP_NO_DRVC.
  // Assertions are conditionally compiled to resolve SYNTH_12611 and SYNTH_5064 for synthesis.
  ASSERT_ALWAYS_TRUE: assert property (p_always_true);
`endif

endmodule
