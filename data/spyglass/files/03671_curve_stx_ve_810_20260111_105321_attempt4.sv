module curve_stx_ve_810_20260111_105321_attempt4(
  input en_feature, // A non-constant input for the generate condition
  input a,
  input b,
  output wire y
);

  // SpyGlass STX_VE_810 rule triggers when a non-constant expression
  // is used where a constant expression is required.
  // In a 'generate if' statement, the condition must be a constant expression
  // resolvable at elaboration time. 'en_feature' is a module input, 
  // making the condition non-constant, which violates this requirement.

  generate
    if (en_feature) begin // STX_VE_810 violation: 'en_feature' is non-constant
      assign y = a & b;
    end else begin
      assign y = a | b;
    end
  endgenerate

endmodule
