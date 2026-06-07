module curve_synth_1084_20260110_121503_attempt5 (
  input wire i_data,
  output wire o_result
);

  localparam TIMING_CONSTRAINT = 20ps; // SYNTH_1084: localparam cannot be assigned a time literal value

  // Simple logic to ensure 'i_data' and 'o_result' are used
  assign o_result = i_data;

endmodule
