// Black box for NV_NVDLA_PDP_RDMA_IG_pipe_p3
module NV_NVDLA_PDP_RDMA_IG_pipe_p3 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mc_int_rd_req_pd_d0
  ,mc_int_rd_req_ready_d1
  ,mc_int_rd_req_valid_d0
  ,mc_int_rd_req_pd_d1
  ,mc_int_rd_req_ready_d0
  ,mc_int_rd_req_valid_d1
);
input nvdla_core_clk;
input nvdla_core_rstn;
input [78:0] mc_int_rd_req_pd_d0;
input mc_int_rd_req_ready_d1;
input mc_int_rd_req_valid_d0;
output [78:0] mc_int_rd_req_pd_d1;
output mc_int_rd_req_ready_d0;
output mc_int_rd_req_valid_d1;
assign mc_int_rd_req_ready_d0 = mc_int_rd_req_ready_d1; // Pass-through ready
assign mc_int_rd_req_pd_d1 = mc_int_rd_req_pd_d0; // Pass-through payload
assign mc_int_rd_req_valid_d1 = mc_int_rd_req_valid_d0; // Pass-through valid
endmodule
