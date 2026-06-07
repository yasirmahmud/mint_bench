module curve_stx_ve_810_20260111_105321_attempt1(
  input enable_feature,
  output wire out_signal
);

  // SpyGlass STX_VE_810 rule triggers when a non-constant expression
  // is used where a constant expression is required.
  // A 'generate if' condition expects a constant expression.
  // 'enable_feature' is an input, thus it is a non-constant signal.

  generate
    // STX_VE_810 violation occurs here:
    // 'enable_feature' is a non-constant expression used in a generate if condition.
    if (enable_feature) begin
      assign out_signal = 1'b1;
    end else begin
      assign out_signal = 1'b0;
    end
  endgenerate

endmodule
