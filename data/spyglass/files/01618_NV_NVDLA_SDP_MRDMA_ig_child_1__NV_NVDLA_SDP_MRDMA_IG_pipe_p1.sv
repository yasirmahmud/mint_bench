module NV_NVDLA_SDP_MRDMA_IG_pipe_p1 (
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

reg [78:0] mc_int_rd_req_pd_r;
reg mc_int_rd_req_valid_r;

assign mc_dma_rd_req_rdy = mc_int_rd_req_ready;
assign mc_int_rd_req_pd = mc_int_rd_req_pd_r;
assign mc_int_rd_req_valid = mc_int_rd_req_valid_r;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    mc_int_rd_req_valid_r <= 1'b0;
    mc_int_rd_req_pd_r <= 0;
  end else begin
    if (mc_int_rd_req_ready) begin
      mc_int_rd_req_valid_r <= mc_dma_rd_req_vld;
      if (mc_dma_rd_req_vld) begin
        mc_int_rd_req_pd_r <= dma_rd_req_pd;
      end
    end
  end
end

endmodule
