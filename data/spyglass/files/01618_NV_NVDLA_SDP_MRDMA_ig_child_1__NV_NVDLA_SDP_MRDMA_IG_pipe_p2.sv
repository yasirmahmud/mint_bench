module NV_NVDLA_SDP_MRDMA_IG_pipe_p2 (
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

reg [78:0] cv_int_rd_req_pd_r;
reg cv_int_rd_req_valid_r;

assign cv_dma_rd_req_rdy = cv_int_rd_req_ready;
assign cv_int_rd_req_pd = cv_int_rd_req_pd_r;
assign cv_int_rd_req_valid = cv_int_rd_req_valid_r;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cv_int_rd_req_valid_r <= 1'b0;
    cv_int_rd_req_pd_r <= 0;
  end else begin
    if (cv_int_rd_req_ready) begin
      cv_int_rd_req_valid_r <= cv_dma_rd_req_vld;
      if (cv_dma_rd_req_vld) begin
        cv_int_rd_req_pd_r <= dma_rd_req_pd;
      end
    end
  end
end

endmodule
