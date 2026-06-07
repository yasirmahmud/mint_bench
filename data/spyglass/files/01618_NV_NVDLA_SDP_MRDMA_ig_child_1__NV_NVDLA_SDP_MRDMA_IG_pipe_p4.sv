module NV_NVDLA_SDP_MRDMA_IG_pipe_p4 (
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

reg [78:0] cv_int_rd_req_pd_d1_r;
reg cv_int_rd_req_valid_d1_r;

assign cv_int_rd_req_ready_d0 = cv_int_rd_req_ready_d1;
assign cv_int_rd_req_pd_d1 = cv_int_rd_req_pd_d1_r;
assign cv_int_rd_req_valid_d1 = cv_int_rd_req_valid_d1_r;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cv_int_rd_req_valid_d1_r <= 1'b0;
    cv_int_rd_req_pd_d1_r <= 0;
  end else begin
    if (cv_int_rd_req_ready_d1) begin
      cv_int_rd_req_valid_d1_r <= cv_int_rd_req_valid_d0;
      if (cv_int_rd_req_valid_d0) begin
        cv_int_rd_req_pd_d1_r <= cv_int_rd_req_pd_d0;
      end
    end
  end
end

endmodule
