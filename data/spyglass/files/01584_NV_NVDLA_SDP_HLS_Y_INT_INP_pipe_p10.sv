module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p10 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,flow_in_pipe2
  ,flow_pipe2_pvld
  ,flow_pipe3_prdy
  ,flow_in_pipe3
  ,flow_pipe2_prdy
  ,flow_pipe3_pvld
  );
input   nvdla_core_clk;
input   nvdla_core_rstn;
input   flow_in_pipe2;
input   flow_pipe2_pvld;
input   flow_pipe3_prdy;
output  flow_in_pipe3;
output  flow_pipe2_prdy;
output  flow_pipe3_pvld;
reg     flow_in_pipe3;
reg     flow_pipe2_prdy;
reg     flow_pipe3_pvld;
reg     p10_pipe_data;
reg     p10_pipe_ready;
reg     p10_pipe_ready_bc;
reg     p10_pipe_valid;
reg     p10_skid_catch;
reg     p10_skid_data;
reg     p10_skid_pipe_data;
reg     p10_skid_pipe_ready;
reg     p10_skid_pipe_valid;
reg     p10_skid_ready;
reg     p10_skid_ready_flop;
reg     p10_skid_valid;
//## pipe (10) skid buffer
always @(
  flow_pipe2_pvld
  or p10_skid_ready_flop
  or p10_skid_pipe_ready
  or p10_skid_valid
  ) begin
  p10_skid_catch = flow_pipe2_pvld && p10_skid_ready_flop && !p10_skid_pipe_ready;  
  p10_skid_ready = (p10_skid_valid)? p10_skid_pipe_ready : !p10_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p10_skid_valid <= 1'b0;
    p10_skid_ready_flop <= 1'b1;
    flow_pipe2_prdy <= 1'b1;
  end else begin
  p10_skid_valid <= (p10_skid_valid)? !p10_skid_pipe_ready : p10_skid_catch;
  p10_skid_ready_flop <= p10_skid_ready;
  flow_pipe2_prdy <= p10_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p10_skid_data <= (p10_skid_catch)? flow_in_pipe2 : p10_skid_data;
  // VCS sop_coverage_off end
end
always @(
  p10_skid_ready_flop
  or flow_pipe2_pvld
  or p10_skid_valid
  or flow_in_pipe2
  or p10_skid_data
  ) begin
  p10_skid_pipe_valid = (p10_skid_ready_flop)? flow_pipe2_pvld : p10_skid_valid; 
  // VCS sop_coverage_off start
  p10_skid_pipe_data = (p10_skid_ready_flop)? flow_in_pipe2 : p10_skid_data;
  // VCS sop_coverage_off end
end
//## pipe (10) valid-ready-bubble-collapse
always @(
  p10_pipe_ready
  or p10_pipe_valid
  ) begin
  p10_pipe_ready_bc = p10_pipe_ready || !p10_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p10_pipe_valid <= 1'b0;
  end else begin
  p10_pipe_valid <= (p10_pipe_ready_bc)? p10_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p10_pipe_data <= (p10_pipe_ready_bc && p10_skid_pipe_valid)? p10_skid_pipe_data : p10_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p10_pipe_ready_bc
  ) begin
  p10_skid_pipe_ready = p10_pipe_ready_bc;
end
//## pipe (10) output
always @(
  p10_pipe_valid
  or flow_pipe3_prdy
  or p10_pipe_data
  ) begin
  flow_pipe3_pvld = p10_pipe_valid;
  p10_pipe_ready = flow_pipe3_prdy;
  flow_in_pipe3 = p10_pipe_data;
end
//## pipe (10) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p10_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_19x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (flow_pipe3_pvld^flow_pipe3_prdy^flow_pipe2_pvld^flow_pipe2_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_20x (nvdla_core_clk, `ASSERT_RESET, (flow_pipe2_pvld && !flow_pipe2_prdy), (flow_pipe2_pvld), (flow_pipe2_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
