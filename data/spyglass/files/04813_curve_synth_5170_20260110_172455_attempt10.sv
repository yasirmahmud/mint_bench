module curve_synth_5170_20260110_172455_attempt10 (
  input  [PARAM_IN_WIDTH - 1 : 0] PORT_ID_IN,
  output [PARAM_OUT_WIDTH - 1 : 0] PORT_ID_OUT
);

  parameter PARAM_IN_WIDTH = 1;
  parameter PARAM_OUT_WIDTH = 1;

  // SYNTH_5170 is triggered because the repetition multiplier
  // (PARAM_OUT_WIDTH - PARAM_IN_WIDTH) evaluates to zero (1 - 1 = 0).
  // This directly matches the rule description and context examples.
  // The output width is 1 (PARAM_OUT_WIDTH), and the concatenation result
  // will be 0 bits (from the replication) + 1 bit (from PORT_ID_IN),
  // totaling 1 bit, which perfectly matches the output port width.
  // This setup avoids syntax errors from literal '0' in replication,
  // and prevents width mismatch or unsized number warnings.
  assign PORT_ID_OUT = {{(PARAM_OUT_WIDTH - PARAM_IN_WIDTH){1'b0}}, PORT_ID_IN};

endmodule
