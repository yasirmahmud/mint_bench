module NV_NVDLA_CDP_HLS_ICVT_pipe_p6 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mul_out_pvld
  ,tru_dout
  ,tru_out_prdy
  ,mul_out_prdy
  ,tru_data_out
  ,tru_out_pvld
  );
input         nvdla_core_clk;
input         nvdla_core_rstn;
input         mul_out_pvld;
input  [16:0] tru_dout;
input         tru_out_prdy;
output        mul_out_prdy;
output [16:0] tru_data_out;
output        tru_out_pvld;
reg           mul_out_prdy;
reg    [16:0] p6_pipe_data;
reg           p6_pipe_ready;
reg           p6_pipe_ready_bc;
reg           p6_pipe_valid;
reg           p6_skid_catch;
reg    [16:0] p6_skid_data;
reg    [16:0] p6_skid_pipe_data;
reg           p6_skid_pipe_ready;
reg           p6_skid_pipe_valid;
reg           p6_skid_ready;
reg           p6_skid_ready_flop;
reg           p6_skid_valid;
reg    [16:0] tru_data_out;
reg           tru_out_pvld;
//## pipe (6) skid buffer
always @(
  mul_out_pvld
  or p6_skid_ready_flop
  or p6_skid_pipe_ready
  or p6_skid_valid
  ) begin
  p6_skid_catch = mul_out_pvld && p6_skid_ready_flop && !p6_skid_pipe_ready;  
  p6_skid_ready = (p6_skid_valid)? p6_skid_pipe_ready : !p6_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p6_skid_valid <= 1'b0;
    p6_skid_ready_flop <= 1'b1;
    mul_out_prdy <= 1'b1;
  end else begin
  p6_skid_valid <= (p6_skid_valid)? !p6_skid_pipe_ready : p6_skid_catch;
  p6_skid_ready_flop <= p6_skid_ready;
  mul_out_prdy <= p6_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p6_skid_data <= (p6_skid_catch)? tru_dout[16:0] : p6_skid_data;
  // VCS sop_coverage_off end
end
always @(
  p6_skid_ready_flop
  or mul_out_pvld
  or p6_skid_valid
  or tru_dout
  or p6_skid_data
  ) begin
  p6_skid_pipe_valid = (p6_skid_ready_flop)? mul_out_pvld : p6_skid_valid; 
  // VCS sop_coverage_off start
  p6_skid_pipe_data = (p6_skid_ready_flop)? tru_dout[16:0] : p6_skid_data;
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
end
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
  or tru_out_prdy
  or p6_pipe_data
  ) begin
  tru_out_pvld = p6_pipe_valid;
  p6_pipe_ready = tru_out_prdy;
  tru_data_out[16:0] = p6_pipe_data;
end
//## pipe (6) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p6_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (tru_out_pvld^tru_out_prdy^mul_out_pvld^mul_out_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_12x (nvdla_core_clk, `ASSERT_RESET, (mul_out_pvld && !mul_out_prdy), (mul_out_pvld), (mul_out_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
