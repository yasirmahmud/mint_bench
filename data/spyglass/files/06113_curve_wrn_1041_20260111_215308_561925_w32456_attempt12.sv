module curve_wrn_1041_20260111_215308_561925_w32456_attempt12 (
  input wire en,
  output wire [3:0] out_data
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  assign out_data = 123_;

endmodule
