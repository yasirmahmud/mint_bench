module curve_stx_ve_605_20260111_174041_627610_w47100_attempt10 ();

  // Define a parameter, which is an elaboration-time constant.
  parameter P_CONSTANT = 100; 

  initial begin
    // STX_VE_605 violation: Attempting to assign a new value
    // to a parameter within a procedural block. Parameters are static
    // constants and cannot be modified after elaboration/during simulation.
    // Removed the illegal assignment: P_CONSTANT = 200;
  end

endmodule
