module curve_wrn_1024_20260111_225654_562626_w28836_attempt11 (
  input signed [7:0] data_in_s,
  output reg signed [7:0] data_out_s
);

  // WRN_1024: 'data_in_s' is already declared as signed, so passing it to $signed() is redundant.
  always @* begin
    data_out_s = $signed(data_in_s);
  end

endmodule
