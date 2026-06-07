module curve_stx_ve_605_20260111_174041_627610_w47100_attempt8 ();

  parameter MY_CONSTANT = 10;

  initial begin
    // STX_VE_605 violation: Attempting to procedurally assign a new value
    // to a parameter, which is a static constant and cannot be modified
    // after elaboration.
    // Removed the illegal assignment to resolve the STX_VE_605 violation.
    // Parameters are static constants and cannot be modified procedurally.
  end

endmodule
