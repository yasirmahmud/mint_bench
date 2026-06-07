module curve_wrn_1024_20260111_095341_attempt1 (
  input wire signed [7:0] data_in,
  output wire signed [7:0] data_out
);

  // WRN_1024: signed argument 'data_in' passed to $signed system function call
  assign data_out = $signed(data_in);

endmodule
