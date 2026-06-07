module top();

  // This module is designed to trigger STX_VE_266 by referencing a non-existent hierarchical path.
  // A dummy register is included to avoid potential unused signal warnings in some lint tools.
  reg dummy_signal;

  initial begin
    // STX_VE_266: Cannot resolve hierarchical reference.
    // The entire path 'U0_formal_verification.grid_clb_1__1_...mem_out' does not exist in this design,
    // as 'top' is a standalone module with no instances.
    dummy_signal = 1'b0; // Use dummy_signal to prevent unused wire warning
  end

endmodule
