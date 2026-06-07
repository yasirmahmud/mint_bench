module curve_stx_ve_605_20260111_174041_627610_w47100_attempt6 ();

  parameter MY_CONSTANT = 10;

  initial begin
    // Parameters are constants and cannot be assigned new values in procedural blocks.
    // The illegal assignment 'MY_CONSTANT = 20;' has been removed to resolve the STX_VE_605 violation.
    // The functional behavior is preserved as parameters are fixed at compile time.
  end

endmodule
