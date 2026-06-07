module NV_NVDLA_ssync3d_c (
   i_clk
  ,i_rstn
  ,sync_i
  ,o_clk
  ,o_rstn
  ,sync_o
  );

input        i_clk;
input        i_rstn;
input        sync_i;
input        o_clk;
input        o_rstn;
output       sync_o;


wire [0:0] sync_i_o_clk_sync_src_data_next;
// 'sync_i_o_clk_sync_src_data' wire and its verilint directives removed 
// as it was set but not read (W528). The corresponding output port is now unconnected.
wire [0:0] sync_i_o_clk_sync_dst_data;

assign sync_i_o_clk_sync_src_data_next = sync_i;
assign sync_o = sync_i_o_clk_sync_dst_data;

p_STRICTSYNC3DOTM_C_PPP sync_i_o_clk_sync_0 (
    .SRC_CLK           (i_clk)
  , .SRC_CLRN        (i_rstn)
  , .SRC_D_NEXT        (sync_i_o_clk_sync_src_data_next[0])
  , .SRC_D             () // Output 'SRC_D' is not used in this module, connected to empty to resolve W528
  , .DST_CLK           (o_clk)
  , .DST_CLRN        (o_rstn)
  , .DST_Q             (sync_i_o_clk_sync_dst_data[0])
  // ATPG_CTL and TEST_MODE connections removed as ports were removed from p_STRICTSYNC3DOTM_C_PPP
  );

endmodule
