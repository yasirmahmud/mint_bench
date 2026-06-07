module curve_wrn_47_20260112_004801_459268_w37744_attempt18 (
  input wire [PARAM_IN_WIDTH - 1 : 0] PORT_ID_IN,
  output wire [PARAM_OUT_WIDTH - 1 : 0] PORT_ID_OUT_A,
  output wire [PARAM_OUT_WIDTH - 1 : 0] PORT_ID_OUT_B
);

  parameter PARAM_IN_WIDTH = 8;
  parameter PARAM_OUT_WIDTH = 8;

  // This assignment triggers WRN_47 because (PARAM_OUT_WIDTH - PARAM_IN_WIDTH) evaluates to (8 - 8) = 0.
  assign PORT_ID_OUT_A = {{(PARAM_OUT_WIDTH - PARAM_IN_WIDTH){1'b0}}, PORT_ID_IN};

  // This second assignment also triggers WRN_47, fulfilling the 'Total occurrences: 2' requirement.
  assign PORT_ID_OUT_B = {{(PARAM_OUT_WIDTH - PARAM_IN_WIDTH){1'b0}}, PORT_ID_IN};

endmodule
