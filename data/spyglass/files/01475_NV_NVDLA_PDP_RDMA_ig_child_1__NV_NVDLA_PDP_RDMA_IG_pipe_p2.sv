// Black box for NV_NVDLA_PDP_RDMA_IG_pipe_p2
module NV_NVDLA_PDP_RDMA_IG_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,cv_dma_rd_req_vld
  ,cv_int_rd_req_ready
  ,dma_rd_req_pd
  ,cv_dma_rd_req_rdy
  ,cv_int_rd_req_pd
  ,cv_int_rd_req_valid
);
input nvdla_core_clk;
input nvdla_core_rstn;
input cv_dma_rd_req_vld;
input cv_int_rd_req_ready;
input [78:0] dma_rd_req_pd;
output cv_dma_rd_req_rdy;
output [78:0] cv_int_rd_req_pd;
output cv_int_rd_req_valid;
assign cv_dma_rd_req_rdy = cv_int_rd_req_ready; // Pass-through ready
assign cv_int_rd_req_pd = dma_rd_req_pd; // Pass-through payload
assign cv_int_rd_req_valid = cv_dma_rd_req_vld; // Pass-through valid
endmodule
