module NV_NVDLA_CDP_HLS_OCVT_pipe_p5 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mul_dout
  ,mul_out_prdy
  ,sub_out_pvld
  ,mul_data_out
  ,mul_out_pvld
  ,sub_out_prdy
  );
input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [49:0] mul_dout;
input         mul_out_prdy;
input         sub_out_pvld;
output [49:0] mul_data_out;
output        mul_out_pvld;
output        sub_out_prdy;
reg    [49:0] mul_data_out;
reg           mul_out_pvld;
reg    [49:0] p5_pipe_data;
reg           p5_pipe_ready;
reg           p5_pipe_ready_bc;
reg           p5_pipe_valid;
reg           p5_skid_catch;
reg    [49:0] p5_skid_data;
reg    [49:0] p5_skid_pipe_data;
reg           p5_skid_pipe_ready;
reg           p5_skid_pipe_valid;
reg           p5_skid_ready;
reg           p5_skid_ready_flop;
reg           p5_skid_valid;
reg           sub_out_prdy;
//## pipe (5) skid buffer
always @(
  sub_out_pvld
  or p5_skid_ready_flop
  or p5_skid_pipe_ready
  or p5_skid_valid
  ) begin
  p5_skid_catch = sub_out_pvld && p5_skid_ready_flop && !p5_skid_pipe_ready;  
  p5_skid_ready = (p5_skid_valid)? p5_skid_pipe_ready : !p5_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p5_skid_valid <= 1'b0;
    p5_skid_ready_flop <= 1'b1;
    sub_out_prdy <= 1'b1;
  end else begin
  p5_skid_valid <= (p5_skid_valid)? !p5_skid_pipe_ready : p5_skid_catch;
  p5_skid_ready_flop <= p5_skid_ready;
  sub_out_prdy <= p5_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p5_skid_data <= (p5_skid_catch)? mul_dout[49:0] : p5_skid_data;
  // VCS sop_coverage_off end
end
always @(
  p5_skid_ready_flop
  or sub_out_pvld
  or p5_skid_valid
  or mul_dout
  or p5_skid_data
  ) begin
  p5_skid_pipe_valid = (p5_skid_ready_flop)? sub_out_pvld : p5_skid_valid; 
  // VCS sop_coverage_off start
  p5_skid_pipe_data = (p5_skid_ready_flop)? mul_dout[49:0] : p5_skid_data;
  // VCS sop_coverage_off end
end
//## pipe (5) valid-ready-bubble-collapse
always @(
  p5_pipe_ready
  or p5_pipe_valid
  ) begin
  p5_pipe_ready_bc = p5_pipe_ready || !p5_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p5_pipe_valid <= 1'b0;
  end else begin
  p5_pipe_valid <= (p5_pipe_ready_bc)? p5_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p5_pipe_data <= (p5_pipe_ready_bc && p5_skid_pipe_valid)? p5_skid_pipe_data : p5_pipe_data;
  // VCS sop_coverage_off end
}
always @(
  p5_pipe_ready_bc
  ) begin
  p5_skid_pipe_ready = p5_pipe_ready_bc;
end
//## pipe (5) output
always @(
  p5_pipe_valid
  or mul_out_prdy
  or p5_pipe_data
  ) begin
  mul_out_pvld = p5_pipe_valid;
  p5_pipe_ready = mul_out_prdy;
  mul_data_out[49:0] = p5_pipe_data;
end
//## pipe (5) assertions/testpoints
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_9x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mul_out_pvld^mul_out_prdy^sub_out_pvld^sub_out_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_10x (nvdla_core_clk, `ASSERT_RESET, (sub_out_pvld && !sub_out_prdy), (sub_out_pvld), (sub_out_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
