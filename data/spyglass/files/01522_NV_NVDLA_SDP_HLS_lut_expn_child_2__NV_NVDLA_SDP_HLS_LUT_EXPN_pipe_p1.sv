// Placeholder module definitions to resolve 'ErrorAnalyzeBBox' violations
// These models implement basic registered pipeline behavior with valid/ready handshake.

module NV_NVDLA_SDP_HLS_LUT_EXPN_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,idx_in_pvld
  ,lut_index_sub
  ,lut_uflow_in
  ,sub_prdy
  ,idx_in_prdy
  ,lut_index_sub_reg
  ,lut_uflow_reg
  ,sub_pvld
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input idx_in_pvld;
input [31:0] lut_index_sub;
input lut_uflow_in;
input sub_prdy;
output wire idx_in_prdy;
output reg [31:0] lut_index_sub_reg;
output reg lut_uflow_reg;
output reg sub_pvld;

assign idx_in_prdy = sub_prdy || !sub_pvld; // Ready if next stage is ready OR this stage is not valid

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    lut_index_sub_reg <= 0;
    lut_uflow_reg <= 0;
    sub_pvld <= 0;
  end else begin
    if (sub_pvld && sub_prdy) begin // Data consumed by next stage
      sub_pvld <= 0;
    end else if (!sub_pvld && idx_in_pvld && idx_in_prdy) begin // New data incoming from previous stage
      lut_index_sub_reg <= lut_index_sub;
      lut_uflow_reg <= lut_uflow_in;
      sub_pvld <= 1;
    end
  end
end
endmodule
