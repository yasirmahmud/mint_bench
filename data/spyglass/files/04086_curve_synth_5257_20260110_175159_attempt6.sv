module curve_synth_5257_20260110_175159_attempt6 #(
  parameter PORT_ID_IN_WIDTH = 1,
  parameter PART_SELECT_HIGH = 1,
  parameter PART_SELECT_LOW  = 1
) (
  input  [PORT_ID_IN_WIDTH - 1 : 0] PORT_ID_IN,
  output out_bit
);

  // SYNTH_5257: Part Select [1:1] on a Vector PORT_ID_IN[0:0] is out of range
  // PORT_ID_IN is [0:0] due to PORT_ID_IN_WIDTH=1.
  // The part select is [1:1] due to PART_SELECT_HIGH=1 and PART_SELECT_LOW=1.
  assign out_bit = PORT_ID_IN[PART_SELECT_HIGH : PART_SELECT_LOW];

endmodule
