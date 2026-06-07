module curve_stx_ve_266_20260111_232120_863482_w49296_attempt11 (
  input wire dummy_in,
  output wire dummy_out
);

  assign dummy_out = dummy_in; // Use dummy_in to prevent unused signal warnings

  initial begin
    // STX_VE_266: Cannot resolve hierarchical reference
    // The following $force statement attempts to modify a signal at a hierarchical path
    // that does not exist in this simple module or any of its sub-modules (none are instantiated).
    // This will trigger the STX_VE_266 violation.
    $force(U0_formal_verification.grid_col_7__7_.logical_tile_clb_mode_clb__0.logical_tile_clb_mode_default__fle_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0.frac_lut4_DFFRQ_mem.mem_data_internal_reg[0], 1'b1);
  end

endmodule
