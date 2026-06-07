module top();

  // A dummy signal to prevent potential unused signal warnings in some lint tools.
  reg dummy_reg;

  initial begin
    // STX_VE_266: Cannot resolve hierarchical reference.
    // This $deposit attempts to access a hierarchical path that does not exist in this module or any instantiated sub-modules.
    // The path 'U0_formal_verification.grid_clb_2__2_...' is purely hypothetical.
    $deposit(U0_formal_verification.grid_clb_2__2_.logical_tile_clb_mode_clb__0.logical_tile_clb_mode_default__fle_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0.frac_lut4_DFFRQ_mem.mem_out[0:7], {8{1'b0}});

    // Assign a value to the dummy signal to avoid unused signal warnings.
    dummy_reg = 1'b0;
  end

endmodule
