module UndrivenClockAssert2(
  input wire sys_clk // Make the clock an input to resolve PRP_NO_DRVC
);
  wire my_undriven_clock = sys_clk; // Drive the original signal with the input clock

`ifdef SYNTHESIS
  // Dummy usage to resolve W528 (Variable 'my_undriven_clock' set but not read)
  // This signal will be optimized out by synthesis, but satisfies linting tool.
  wire unused_placeholder_for_my_undriven_clock; // Declare an unused wire
  assign unused_placeholder_for_my_undriven_clock = my_undriven_clock; // Assign the problematic wire to the unused one
`endif

`ifndef SYNTHESIS
  property p_always_true;
    @(posedge my_undriven_clock) 1'b1;
  endproperty

  // my_undriven_clock is now driven, resolving PRP_NO_DRVC.
  // Assertions are conditionally compiled to resolve SYNTH_12611 and SYNTH_5064 for synthesis.
  ASSERT_ALWAYS_TRUE: assert property (p_always_true);
`endif

endmodule
