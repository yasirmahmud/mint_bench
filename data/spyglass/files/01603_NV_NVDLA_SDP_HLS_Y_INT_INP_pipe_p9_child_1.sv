module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p9 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,flow_in_pipe1
  ,flow_pipe1_pvld
  ,flow_pipe2_prdy
  ,flow_in_pipe2
  ,flow_pipe1_prdy
  ,flow_pipe2_pvld
  );
input   nvdla_core_clk;
input   nvdla_core_rstn;
input   flow_in_pipe1;
input   flow_pipe1_pvld;
input   flow_pipe2_prdy;
output  flow_in_pipe2;
output  flow_pipe1_prdy;
output  flow_pipe2_pvld;
reg     flow_in_pipe2;
reg     flow_pipe1_prdy;
reg     flow_pipe2_pvld;
reg     p9_pipe_data;
reg     p9_pipe_ready;
reg     p9_pipe_ready_bc;
reg     p9_pipe_valid;
reg     p9_skid_catch;
reg     p9_skid_data;
reg     p9_skid_pipe_data;
reg     p9_skid_pipe_ready;
reg     p9_skid_pipe_valid;
reg     p9_skid_ready;
reg     p9_skid_ready_flop;
reg     p9_skid_valid;
//## pipe (9) skid buffer
always @(
  flow_pipe1_pvld
  or p9_skid_ready_flop
  or p9_skid_pipe_ready
  or p9_skid_valid
  ) begin
  p9_skid_catch = flow_pipe1_pvld && p9_skid_ready_flop && !p9_skid_pipe_ready;  
  p9_skid_ready = (p9_skid_valid)? p9_skid_pipe_ready : !p9_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p9_skid_valid <= 1'b0;
    p9_skid_ready_flop <= 1'b1;
    flow_pipe1_prdy <= 1'b1;
  end else begin
  p9_skid_valid <= (p9_skid_valid)? !p9_skid_pipe_ready : p9_skid_catch;
  p9_skid_ready_flop <= p9_skid_ready;
  flow_pipe1_prdy <= p9_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p9_skid_data <= (p9_skid_catch)? flow_in_pipe1 : p9_skid_data;
  // VCS sop_coverage_off end
end
always @(
  p9_skid_ready_flop
  or flow_pipe1_pvld
  or p9_skid_valid
  or flow_in_pipe1
  or p9_skid_data
  ) begin
  p9_skid_pipe_valid = (p9_skid_ready_flop)? flow_pipe1_pvld : p9_skid_valid; 
  // VCS sop_coverage_off start
  p9_skid_pipe_data = (p9_skid_ready_flop)? flow_in_pipe1 : p9_skid_data;
  // VCS sop_coverage_off end
end
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
  p9_pipe_valid <= (p9_pipe_ready_bc)? p9_skid_pipe_valid : 1'd1;
  end
}
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p9_pipe_data <= (p9_pipe_ready_bc && p9_skid_pipe_valid)? p9_skid_pipe_data : p9_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p9_pipe_ready_bc
  ) begin
  p9_skid_pipe_ready = p9_pipe_ready_bc;
end
//## pipe (9) output
always @(
  p9_pipe_valid
  or flow_pipe2_prdy
  or p9_pipe_data
  ) begin
  flow_pipe2_pvld = p9_pipe_valid;
  p9_pipe_ready = flow_pipe2_prdy;
  flow_in_pipe2 = p9_pipe_data;
end
//## pipe (9) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_17x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (flow_pipe2_pvld^flow_pipe2_prdy^flow_pipe1_pvld^flow_pipe1_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_18x (nvdla_core_clk, `ASSERT_RESET, (flow_pipe1_pvld && !flow_pipe1_prdy), (flow_pipe1_pvld), (flow_pipe1_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
