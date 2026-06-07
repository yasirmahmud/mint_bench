// Black box for NV_NVDLA_PDP_RDMA_IG_pipe_p4
module NV_NVDLA_PDP_RDMA_IG_pipe_p4 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,cv_int_rd_req_pd_d0
  ,cv_int_rd_req_ready_d1
  ,cv_int_rd_req_valid_d0
  ,cv_int_rd_req_pd_d1
  ,cv_int_rd_req_ready_d0
  ,cv_int_rd_req_valid_d1
);
input nvdla_core_clk;
input nvdla_core_rstn;
input [78:0] cv_int_rd_req_pd_d0;
input cv_int_rd_req_ready_d1;
input cv_int_rd_req_valid_d0;
output [78:0] cv_int_rd_req_pd_d1;
output cv_int_rd_req_ready_d0;
output cv_int_rd_req_valid_d1;
assign cv_int_rd_req_ready_d0 = cv_int_rd_req_ready_d1; // Pass-through ready
assign cv_int_rd_req_pd_d1 = cv_int_rd_req_pd_d0; // Pass-through payload
assign cv_int_rd_req_valid_d1 = cv_int_rd_req_valid_d0; // Pass-through valid
endmodule
