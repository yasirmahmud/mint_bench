module NV_NVDLA_SDP_MRDMA_IG_pipe_p3 (
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

reg [78:0] mc_int_rd_req_pd_d1_r;
reg mc_int_rd_req_valid_d1_r;

assign mc_int_rd_req_ready_d0 = mc_int_rd_req_ready_d1;
assign mc_int_rd_req_pd_d1 = mc_int_rd_req_pd_d1_r;
assign mc_int_rd_req_valid_d1 = mc_int_rd_req_valid_d1_r;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    mc_int_rd_req_valid_d1_r <= 1'b0;
    mc_int_rd_req_pd_d1_r <= 0;
  end else begin
    if (mc_int_rd_req_ready_d1) begin
      mc_int_rd_req_valid_d1_r <= mc_int_rd_req_valid_d0;
      if (mc_int_rd_req_valid_d0) begin
        mc_int_rd_req_pd_d1_r <= mc_int_rd_req_pd_d0;
      end
    end
  end
end

endmodule
