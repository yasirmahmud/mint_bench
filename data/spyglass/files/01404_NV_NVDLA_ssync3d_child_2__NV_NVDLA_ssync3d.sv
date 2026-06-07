module NV_NVDLA_ssync3d (
   i_clk
  ,sync_i
  ,o_clk
  ,sync_o
  );

input        i_clk;
input        sync_i;
input        o_clk;
output       sync_o;


wire [0:0] sync_i_o_clk_sync_src_data_next;
// Fix for W528: Variable 'sync_i_o_clk_sync_src_data' set but not read.
// The output '.SRC_D' from 'p_STRICTSYNC3DOTM' is not used by 'NV_NVDLA_ssync3d'.
// The wire declaration has been removed, and the port is now tied off with an empty connection.
wire [0:0] sync_i_o_clk_sync_dst_data;

assign sync_i_o_clk_sync_src_data_next = sync_i;
assign sync_o = sync_i_o_clk_sync_dst_data;

p_STRICTSYNC3DOTM sync_i_o_clk_sync_0 (
    .SRC_CLK           (i_clk)
  , .SRC_D_NEXT        (sync_i_o_clk_sync_src_data_next[0])
  , .SRC_D             () // Tied off unused output, resolves W528
  , .DST_CLK           (o_clk)
  , .DST_Q             (sync_i_o_clk_sync_dst_data[0])
  , .ATPG_CTL          (1'b0)
  , .TEST_MODE         (1'b0)
  );

endmodule
