module NV_NVDLA_SDP_RDMA_EG_ro #(
  parameter NVDLA_MEMORY_ATOMIC_SIZE= 4,
  parameter AM_DW                   = 32,
  parameter AM_DW2                  = NVDLA_MEMORY_ATOMIC_SIZE * AM_DW - 1
) (
   input         nvdla_core_clk
  ,input         nvdla_core_rstn
  ,input  [31:0] pwrbus_ram_pd
  ,output        sdp_rdma2dp_valid
  ,input         sdp_rdma2dp_ready
  ,output [AM_DW2:0] sdp_rdma2dp_pd
  ,input  [AM_DW-1:0] rod0_wr_pd
  ,input  [AM_DW-1:0] rod1_wr_pd
  ,input  [AM_DW-1:0] rod2_wr_pd
  ,input  [AM_DW-1:0] rod3_wr_pd
  ,input  [3:0]  rod_wr_mask
  ,input         rod_wr_vld
  ,output        rod_wr_rdy
  ,input  [1:0]  roc_wr_pd
  ,input         roc_wr_vld
  ,output        roc_wr_rdy
  ,input         cfg_dp_8
  ,input         cfg_dp_size_1byte
  ,input         cfg_mode_per_element
  `ifdef NVDLA_BATCH_ENABLE
  ,input  [4:0]  reg2dp_batch_number
  `endif
  ,input  [12:0] reg2dp_channel
  ,input  [12:0] reg2dp_height
  ,input  [12:0] reg2dp_width
  ,output        layer_end
);
// Black box - placeholder to resolve 'no definition' lint error
// Outputs are assigned dummy values or pass-through for minimal simulation functionality
assign sdp_rdma2dp_valid = 1'b0;
assign sdp_rdma2dp_pd = '0;
assign rod_wr_rdy = 1'b1;
assign roc_wr_rdy = 1'b1;
assign layer_end = 1'b0;
endmodule
