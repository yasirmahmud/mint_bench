`ifndef SYNTHESIS
// Dummy definition for NV_NVDLA_SDP_RDMA_REG_single
module NV_NVDLA_SDP_RDMA_REG_single (
   reg_rd_data
  ,reg_offset
  ,reg_wr_data
  ,reg_wr_en
  ,nvdla_core_clk
  ,nvdla_core_rstn
  ,producer
  ,consumer
  ,status_0
  ,status_1
  );

input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [11:0] reg_offset;
input  [31:0] reg_wr_data;
input         reg_wr_en;
input         consumer;
input  [1:0]  status_0;
input  [1:0]  status_1;
output [31:0] reg_rd_data;
output        producer;

reg [31:0] r_reg_data;
reg        r_producer;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        r_reg_data <= 32'b0;
        r_producer <= 1'b0;
    end else begin
        if (reg_wr_en) begin
            r_reg_data <= reg_wr_data;
        end
        // Dummy producer toggle for simulation, functional behavior not needed for linting bbox
        // Simplified logic: toggle producer on any write to reflect activity, or keep 0.
        r_producer <= ~r_producer; // Toggling on clock for simulation
    end
end
assign reg_rd_data = r_reg_data;
assign producer = r_producer;

endmodule
