module curve_w421_20260111_084734_attempt1 ();

  // W421: No event control (@) in always block
  // This always block uses a delay control (#1) instead of an event control (@* or @posedge clk).
  // It is also non-synthesizable.
  // Using $display avoids introducing registers, thereby preventing W528 (uninitialized register) or
  // multiple driver violations that would occur if a reg were used and needed initialization.
  always #1 $display("This always block violates W421.");

endmodule
