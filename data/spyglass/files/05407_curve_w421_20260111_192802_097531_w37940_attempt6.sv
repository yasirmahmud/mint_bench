module curve_w421_20260111_192802_097531_w37940_attempt6 (
  output reg my_clock
);

  initial begin
    my_clock = 1'b0;
  end

  // W421 violation: No event control (@) in always block
  always #7 my_clock = ~my_clock;

endmodule
