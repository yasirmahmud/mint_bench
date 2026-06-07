module curve_wrn_1041_20260112_001643_177505_w47152_attempt13 (
  output reg out_signal
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  always @* begin
    out_signal = 1'b1_;
  end

endmodule
