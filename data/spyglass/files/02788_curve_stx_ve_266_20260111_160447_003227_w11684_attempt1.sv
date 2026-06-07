module curve_stx_ve_266_20260111_160447_003227_w11684_attempt1 (
  input wire clk,
  input wire rst,
  output reg out_signal
);

  // This initial block attempts to deposit a value to a hierarchical reference
  // that is explicitly not defined within this module or any of its sub-modules.
  // This causes SpyGlass to report a 'Cannot resolve hierarchical reference' violation (STX_VE_266).
  initial begin
    $deposit(U0_formal_verification.grid_clb_1__1_.logical_tile_clb_mode_clb__0.logical_tile_clb_mode_default__fle_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0.logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0.frac_lut4_DFFRQ_mem.mem_out[0:16], {17{1'b0}});
  end

  // Minimal RTL to prevent 'unused signal' or 'undriven output' warnings/violations
  // that could trigger other SpyGlass rules, ensuring only STX_VE_266 is reported.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out_signal <= 1'b0;
    end else begin
      out_signal <= ~out_signal;
    end
  end

endmodule
