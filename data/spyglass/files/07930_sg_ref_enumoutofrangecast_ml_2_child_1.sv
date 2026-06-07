module enum_out_of_range_cast_ex2 (
  output color_t out_color
);
  typedef enum {RED, GREEN, BLUE} color_t;
  color_t my_color;

  // Original behavior was 'my_color = color_t'(5);' in an initial block.
  // This caused an EnumOutOfRangeCast-ML violation due to '5' being out of range for {RED, GREEN, BLUE}.
  // It also caused SYNTH_5143 (initial block ignored for synthesis) and W528 (variable set but not read).
  //
  // To resolve EnumOutOfRangeCast-ML and SYNTH_5143, 'my_color' is now continuously assigned
  // a valid enum value (BLUE) in a synthesizable manner, replacing the initial block.
  assign my_color = BLUE;

  // To resolve W528, 'my_color' is now connected to an output port 'out_color'.
  assign out_color = my_color;

endmodule
