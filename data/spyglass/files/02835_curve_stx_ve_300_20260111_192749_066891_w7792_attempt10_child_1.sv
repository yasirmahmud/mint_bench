module curve_stx_ve_300_20260111_192749_066891_w7792_attempt10 (
  // No inputs/outputs required to demonstrate the violation
);

  // Declare a SystemVerilog constant logic variable.
  // The 'const' keyword and 'logic' type are SystemVerilog features,
  // but are essential to trigger the STX_VE_300 rule.
  const logic [3:0] ERROR_CODE = 4'b0001;

  // The original illegal re-assignment has been removed
  // to resolve the STX_VE_300 violation, as 'const' variables
  // cannot be re-assigned after their declaration.

endmodule
