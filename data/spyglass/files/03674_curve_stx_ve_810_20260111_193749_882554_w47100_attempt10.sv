module curve_stx_ve_810_20260111_193749_882554_w47100_attempt10 (
  input enable_feature, // A module input, which is a non-constant expression
  input [7:0] data_in,
  output [7:0] data_out
);

  // STX_VE_810 violation: The condition of a generate if statement must be a constant expression.
  // Here, 'enable_feature' is a module input, making the condition non-constant
  // at elaboration time, thus violating the rule.
  generate
    if (enable_feature) begin // Violation occurs here, as 'enable_feature' is not a constant
      assign data_out = data_in + 1;
    end else begin
      assign data_out = data_in - 1;
    end
  endgenerate

endmodule
