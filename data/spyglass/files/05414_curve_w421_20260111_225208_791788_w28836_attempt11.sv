module curve_w421_20260111_225208_791788_w28836_attempt11 (
  output reg data_out
);

  // W421: This always block uses a timing control (#3) but lacks an event control (@).
  // It assigns a constant after a delay, avoiding other violations like latches or combinational loops.
  always #3 data_out = 1'b1;

endmodule
