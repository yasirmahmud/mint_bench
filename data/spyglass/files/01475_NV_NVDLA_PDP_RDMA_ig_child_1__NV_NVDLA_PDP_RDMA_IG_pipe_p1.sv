module NV_NVDLA_PDP_RDMA_IG_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dma_rd_req_pd
  ,mc_dma_rd_req_vld
  ,mc_int_rd_req_ready
  ,mc_dma_rd_req_rdy
  ,mc_int_rd_req_pd
  ,mc_int_rd_req_valid
);
input nvdla_core_clk;
input nvdla_core_rstn;
input [78:0] dma_rd_req_pd;
input mc_dma_rd_req_vld;
input mc_int_rd_req_ready;
output mc_dma_rd_req_rdy;
output [78:0] mc_int_rd_req_pd;
output mc_int_rd_req_valid;
assign mc_dma_rd_req_rdy = mc_int_rd_req_ready; // Pass-through ready
assign mc_int_rd_req_pd = dma_rd_req_pd; // Pass-through payload
assign mc_int_rd_req_valid = mc_dma_rd_req_vld; // Pass-through valid
endmodule
