module FP_SUM_BLOCK_pipe_p9 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,stage2_pipe_in_pd_d0
  ,stage2_pipe_in_rdy_d1
  ,stage2_pipe_in_vld_d0
  ,stage2_pipe_in_pd_d1
  ,stage2_pipe_in_rdy_d0
  ,stage2_pipe_in_vld_d1
  );
input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [63:0] stage2_pipe_in_pd_d0;
input         stage2_pipe_in_rdy_d1;
input         stage2_pipe_in_vld_d0;
output [63:0] stage2_pipe_in_pd_d1;
output        stage2_pipe_in_rdy_d0;
output        stage2_pipe_in_vld_d1;
reg    [63:0] p9_pipe_data;
reg           p9_pipe_ready;
reg           p9_pipe_ready_bc;
reg           p9_pipe_valid;
reg    [63:0] stage2_pipe_in_pd_d1;
reg           stage2_pipe_in_rdy_d0;
reg           stage2_pipe_in_vld_d1;
//## pipe (9) valid-ready-bubble-collapse
always @(
  p9_pipe_ready
  or p9_pipe_valid
  ) begin
  p9_pipe_ready_bc = p9_pipe_ready || !p9_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p9_pipe_valid <= 1'b0;
  end else begin
  p9_pipe_valid <= (p9_pipe_ready_bc)? stage2_pipe_in_vld_d0 : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p9_pipe_data <= (p9_pipe_ready_bc && stage2_pipe_in_vld_d0)? stage2_pipe_in_pd_d0[63:0] : p9_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p9_pipe_ready_bc
  ) begin
  stage2_pipe_in_rdy_d0 = p9_pipe_ready_bc;
end
//## pipe (9) output
always @(
  p9_pipe_valid
  or stage2_pipe_in_rdy_d1
  or p9_pipe_data
  ) begin
  stage2_pipe_in_vld_d1 = p9_pipe_valid;
  p9_pipe_ready = stage2_pipe_in_rdy_d1;
  stage2_pipe_in_pd_d1[63:0] = p9_pipe_data;
end
//## pipe (9) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p9_assert_clk = nvdla_core_clk;
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
  // VCS coverage off 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_17x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (stage2_pipe_in_vld_d1^stage2_pipe_in_rdy_d1^stage2_pipe_in_vld_d0^stage2_pipe_in_rdy_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
  // VCS coverage off 
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_18x (nvdla_core_clk, `ASSERT_RESET, (stage2_pipe_in_vld_d0 && !stage2_pipe_in_rdy_d0), (stage2_pipe_in_vld_d0), (stage2_pipe_in_rdy_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`endif
endmodule
