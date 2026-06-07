module EnumOutOfRangeCast_ex1(
  output color_t my_color
);
  typedef enum {RED, GREEN, BLUE} color_t;

  // Fix EnumOutOfRangeCast-ML: Assign a valid enum member instead of an out-of-range value (3).
  // Fix SYNTH_5143: Remove the non-synthesizable 'initial' block by assigning directly.
  // Fix W528: Make 'my_color' an output so it is effectively 'read' by the external environment.
  assign my_color = BLUE;

endmodule
