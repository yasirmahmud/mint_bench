module UndrivenClockAssert2();
  wire my_undriven_clock;

  property p_always_true;
    @(posedge my_undriven_clock) 1'b1;
  endproperty

  // my_undriven_clock is used as a clock in property p_always_true but is never driven.
  ASSERT_ALWAYS_TRUE: assert property (p_always_true);

endmodule
