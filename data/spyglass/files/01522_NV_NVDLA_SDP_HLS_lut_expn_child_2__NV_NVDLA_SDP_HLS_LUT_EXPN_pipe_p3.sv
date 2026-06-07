module NV_NVDLA_SDP_HLS_LUT_EXPN_pipe_p3 (
   input         nvdla_core_clk
  ,input         nvdla_core_rstn
  ,input         idx_out_prdy
  ,input         log2_pvld
  ,input  [34:0] lut_frac_final
  ,input  [8:0]  lut_index_final
  ,input         lut_oflow_final
  ,input         lut_uflow_final
  ,output reg    idx_out_pvld
  ,output wire   log2_prdy
  ,output reg [34:0] lut_frac_out
  ,output reg [8:0]  lut_index_out
  ,output reg    lut_oflow_out
  ,output reg    lut_uflow_out
  )
; // Fix for STX_VE_606, STX_VE_569, and STX_VE_481: Converted to ANSI C-style port declarations and removed redundant internal declarations.

assign log2_prdy = idx_out_prdy || !idx_out_pvld; // Ready for previous stage if next stage is ready OR this stage is not valid

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    lut_frac_out <= 0;
    lut_index_out <= 0;
    lut_oflow_out <= 0;
    lut_uflow_out <= 0;
    idx_out_pvld <= 0;
  end else begin
    if (idx_out_pvld && idx_out_prdy) begin // Data consumed by top-level module
      idx_out_pvld <= 0;
    end else if (!idx_out_pvld && log2_pvld && log2_prdy) begin // New data incoming from previous stage
      lut_frac_out <= lut_frac_final;
      lut_index_out <= lut_index_final;
      lut_oflow_out <= lut_oflow_final;
      lut_uflow_out <= lut_uflow_final;
      idx_out_pvld <= 1;
    }
  }
end
endmodule
