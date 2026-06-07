module top();

  // A dummy signal to prevent potential unused signal warnings in some lint tools.
  reg dummy_reg;

  initial begin
    // The original $deposit call referred to a hierarchical path that does not exist in the design.
    // Removing it resolves the STX_VE_266 violation while preserving functional behavior,
    // as the original call would have had no effect.

    // Assign a value to the dummy signal to avoid unused signal warnings.
    dummy_reg = 1'b0;
  end

endmodule
