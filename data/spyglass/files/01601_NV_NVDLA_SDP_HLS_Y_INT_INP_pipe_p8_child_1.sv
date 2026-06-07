module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p8 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,flow_pipe1_prdy
  ,inp_flow_in
  ,inp_flow_pvld
  ,flow_in_pipe1
  ,inp_flow_prdy
  ,flow_pipe1_pvld
  );
input   nvdla_core_clk;
input   nvdla_core_rstn;
input   flow_pipe1_prdy;
input   inp_flow_in;
input   inp_flow_pvld;
output  flow_in_pipe1;
output  inp_flow_prdy;
output  flow_pipe1_pvld;
reg     flow_in_pipe1;
reg     inp_flow_prdy;
reg     flow_pipe1_pvld;
reg     p8_pipe_data;
reg     p8_pipe_ready;
reg     p8_pipe_ready_bc;
reg     p8_pipe_valid;
reg     p8_skid_catch;
reg     p8_skid_data;
reg     p8_skid_pipe_data;
reg     p8_skid_pipe_ready;
reg     p8_skid_pipe_valid;
reg     p8_skid_ready;
reg     p8_skid_ready_flop;
reg     p8_skid_valid;
//## pipe (8) skid buffer
always @(
  inp_flow_pvld
  or p8_skid_ready_flop
  or p8_skid_pipe_ready
  or p8_skid_valid
  ) begin
  p8_skid_catch = inp_flow_pvld && p8_skid_ready_flop && !p8_skid_pipe_ready;  
  p8_skid_ready = (p8_skid_valid)? p8_skid_pipe_ready : !p8_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p8_skid_valid <= 1'b0;
    p8_skid_ready_flop <= 1'b1;
    inp_flow_prdy <= 1'b1;
  end else begin
  p8_skid_valid <= (p8_skid_valid)? !p8_skid_pipe_ready : p8_skid_catch;
  p8_skid_ready_flop <= p8_skid_ready;
  inp_flow_prdy <= p8_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p8_skid_data <= (p8_skid_catch)? inp_flow_in : p8_skid_data;
  // VCS sop_coverage_off end
end
always @(
  p8_skid_ready_flop
  or inp_flow_pvld
  or p8_skid_valid
  or inp_flow_in
  or p8_skid_data
  ) begin
  p8_skid_pipe_valid = (p8_skid_ready_flop)? inp_flow_pvld : p8_skid_valid; 
  // VCS sop_coverage_off start
  p8_skid_pipe_data = (p8_skid_ready_flop)? inp_flow_in : p8_skid_data;
  // VCS sop_coverage_off end
end
//## pipe (8) valid-ready-bubble-collapse
always @(
  p8_pipe_ready
  or p8_pipe_valid
  ) begin
  p8_pipe_ready_bc = p8_pipe_ready || !p8_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p8_pipe_valid <= 1'b0;
  end else begin
  p8_pipe_valid <= (p8_pipe_ready_bc)? p8_skid_pipe_valid : 1'd1;
  end
}
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p8_pipe_data <= (p8_pipe_ready_bc && p8_skid_pipe_valid)? p8_skid_pipe_data : p8_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p8_pipe_ready_bc
  ) begin
  p8_skid_pipe_ready = p8_pipe_ready_bc;
end
//## pipe (8) output
always @(
  p8_pipe_valid
  or flow_pipe1_prdy
  or p8_pipe_data
  ) begin
  flow_pipe1_pvld = p8_pipe_valid;
  p8_pipe_ready = flow_pipe1_prdy;
  flow_in_pipe1 = p8_pipe_data;
end
//## pipe (8) assertions/testpoints
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_15x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (flow_pipe1_pvld^flow_pipe1_prdy^inp_flow_pvld^inp_flow_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_16x (nvdla_core_clk, `ASSERT_RESET, (inp_flow_pvld && !inp_flow_prdy), (inp_flow_pvld), (inp_flow_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
