module curve_stx_ve_266_20260111_202634_122485_w37940_attempt10();

  initial begin
    // STX_VE_266: Cannot resolve hierarchical reference.
    // This $deposit attempts to access a hierarchical path that does not exist in this module or any instantiated sub-modules.
    // The path 'U0_formal_verification.grid_col_5__5_...' is purely hypothetical.
    $deposit(U0_formal_verification.grid_col_5__5_.logical_tile_clb_mode_clb__0.logical_tile_clb_mode_default__fle_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0.frac_lut4_DFFRQ_mem.mem_out[0:15], {16{1'b1}});
  end

endmodule
