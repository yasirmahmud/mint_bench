module NV_NVDLA_SDP_HLS_LUT_EXPN_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,log2_lut_frac
  ,log2_lut_index_tru
  ,log2_prdy
  ,lut_uflow_reg
  ,sub_pvld
  ,log2_lut_frac_reg
  ,log2_lut_index_reg
  ,log2_pvld
  ,lut_uflow_reg2
  ,sub_prdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] log2_lut_frac;
input [8:0] log2_lut_index_tru;
input log2_prdy;
input lut_uflow_reg;
input sub_pvld; // Input valid from pipe_p1

output wire sub_prdy; // Output ready for pipe_p1
output reg [31:0] log2_lut_frac_reg;
output reg [8:0] log2_lut_index_reg;
output reg log2_pvld; // Output valid for pipe_p3
output reg lut_uflow_reg2;

assign sub_prdy = log2_prdy || !log2_pvld; // Ready for previous stage if next stage is ready OR this stage is not valid

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    log2_lut_frac_reg <= 0;
    log2_lut_index_reg <= 0;
    lut_uflow_reg2 <= 0;
    log2_pvld <= 0;
  end else begin
    if (log2_pvld && log2_prdy) begin // Data consumed by next stage
      log2_pvld <= 0;
    end else if (!log2_pvld && sub_pvld && sub_prdy) begin // New data incoming from previous stage
      log2_lut_frac_reg <= log2_lut_frac;
      log2_lut_index_reg <= log2_lut_index_tru;
      lut_uflow_reg2 <= lut_uflow_reg;
      log2_pvld <= 1;
    end
  end
end // Fix for STX_VE_481: Changed '}' to 'end'
endmodule
