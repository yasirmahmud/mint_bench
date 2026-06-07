// =======================================================
// Black box definitions for sub-modules to resolve lint errors
// =======================================================

module NV_NVDLA_SDP_RDMA_unpack #(
  parameter NVDLA_DMA_RD_RSP        = 512,
  parameter NVDLA_DMA_MASK_BIT      = 4,
  parameter NVDLA_MEMIF_WIDTH       = NVDLA_DMA_RD_RSP - NVDLA_DMA_MASK_BIT,
  parameter NVDLA_MEMORY_ATOMIC_SIZE= 4,
  parameter AM_DW                   = 32,
  parameter AM_DW2                  = NVDLA_MEMORY_ATOMIC_SIZE * AM_DW - 1
) (
   input         nvdla_core_clk
  ,input         nvdla_core_rstn
  ,input [NVDLA_DMA_RD_RSP-1:0] inp_data
  ,input         inp_pvld
  ,output        inp_prdy
  ,input         inp_end
  ,output [4*AM_DW+3:0]  out_data
  ,output        out_pvld
  ,input         out_prdy
);
// Black box - placeholder to resolve 'no definition' lint error
// Outputs are assigned dummy values or pass-through for minimal simulation functionality
assign inp_prdy = out_prdy;
assign out_pvld = inp_pvld;
assign out_data = '0;
endmodule
