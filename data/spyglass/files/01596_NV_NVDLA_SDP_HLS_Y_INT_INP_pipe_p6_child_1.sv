module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p6 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,intp_sum
  ,sum_in_pvld
  ,sum_out_prdy
  ,intp_sum_reg
  ,sum_in_prdy
  ,sum_out_pvld
  );
input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [52:0] intp_sum;
input         sum_in_pvld;
input         sum_out_prdy;
output [52:0] intp_sum_reg;
output        sum_in_prdy;
output        sum_out_pvld;
reg    [52:0] intp_sum_reg;
reg    [52:0] p6_pipe_data;
reg           p6_pipe_ready;
reg           p6_pipe_ready_bc;
reg           p6_pipe_valid;
reg           p6_skid_catch;
reg    [52:0] p6_skid_data;
reg    [52:0] p6_skid_pipe_data;
reg           p6_skid_pipe_ready;
reg           p6_skid_pipe_valid;
reg           p6_skid_ready;
reg           p6_skid_ready_flop;
reg           p6_skid_valid;
reg           sum_in_prdy;
reg           sum_out_pvld;
//## pipe (6) skid buffer
always @(
  sum_in_pvld
  or p6_skid_ready_flop
  or p6_skid_pipe_ready
  or p6_skid_valid
  ) begin
  p6_skid_catch = sum_in_pvld && p6_skid_ready_flop && !p6_skid_pipe_ready;  
  p6_skid_ready = (p6_skid_valid)? p6_skid_pipe_ready : !p6_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p6_skid_valid <= 1'b0;
    p6_skid_ready_flop <= 1'b1;
    sum_in_prdy <= 1'b1;
  end else begin
  p6_skid_valid <= (p6_skid_valid)? !p6_skid_pipe_ready : p6_skid_catch;
  p6_skid_ready_flop <= p6_skid_ready;
  sum_in_prdy <= p6_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p6_skid_data <= (p6_skid_catch)? intp_sum[52:0] : p6_skid_data;
  // VCS sop_coverage_off end
end
always @(
  p6_skid_ready_flop
  or sum_in_pvld
  or p6_skid_valid
  or intp_sum
  or p6_skid_data
  ) begin
  p6_skid_pipe_valid = (p6_skid_ready_flop)? sum_in_pvld : p6_skid_valid; 
  // VCS sop_coverage_off start
  p6_skid_pipe_data = (p6_skid_ready_flop)? intp_sum[52:0] : p6_skid_data;
  // VCS sop_coverage_off end
end
//## pipe (6) valid-ready-bubble-collapse
always @(
  p6_pipe_ready
  or p6_pipe_valid
  ) begin
  p6_pipe_ready_bc = p6_pipe_ready || !p6_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p6_pipe_valid <= 1'b0;
  end else begin
  p6_pipe_valid <= (p6_pipe_ready_bc)? p6_skid_pipe_valid : 1'd1;
  end
}
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p6_pipe_data <= (p6_pipe_ready_bc && p6_skid_pipe_valid)? p6_skid_pipe_data : p6_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p6_pipe_ready_bc
  ) begin
  p6_skid_pipe_ready = p6_pipe_ready_bc;
end
//## pipe (6) output
always @(
  p6_pipe_valid
  or sum_out_prdy
  or p6_pipe_data
  ) begin
  sum_out_pvld = p6_pipe_valid;
  p6_pipe_ready = sum_out_prdy;
  intp_sum_reg[52:0] = p6_pipe_data;
end
//## pipe (6) assertions/testpoints
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (sum_out_pvld^sum_out_prdy^sum_in_pvld^sum_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_12x (nvdla_core_clk, `ASSERT_RESET, (sum_in_pvld && !sum_in_prdy), (sum_in_pvld), (sum_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
