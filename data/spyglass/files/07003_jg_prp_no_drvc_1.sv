module UndrivenClockAssert1();
  logic undriven_clk;

  // undriven_clk is used as a clock in this assertion but is never driven.
  assert property (@(posedge undriven_clk) 1'b1);

endmodule
