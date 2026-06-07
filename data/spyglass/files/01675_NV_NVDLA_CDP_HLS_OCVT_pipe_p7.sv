module NV_NVDLA_CDP_HLS_OCVT_pipe_p7 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,chn_dout
  ,chn_out_prdy
  ,tru_final_pvld
  ,chn_data_out
  ,chn_out_pvld
  ,tru_final_prdy
  );
input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [17:0] chn_dout;
input         chn_out_prdy;
input         tru_final_pvld;
output [17:0] chn_data_out;
output        chn_out_pvld;
output        tru_final_prdy;
reg    [17:0] chn_data_out;
reg           chn_out_pvld;
reg    [17:0] p7_pipe_data;
reg           p7_pipe_ready;
reg           p7_pipe_ready_bc;
reg           p7_pipe_valid;
reg           p7_skid_catch;
reg    [17:0] p7_skid_data;
reg    [17:0] p7_skid_pipe_data;
reg           p7_skid_pipe_ready;
reg           p7_skid_pipe_valid;
reg           p7_skid_ready;
reg           p7_skid_ready_flop;
reg           p7_skid_valid;
reg           tru_final_prdy;
//## pipe (7) skid buffer
always @(
  tru_final_pvld
  or p7_skid_ready_flop
  or p7_skid_pipe_ready
  or p7_skid_valid
  ) begin
  p7_skid_catch = tru_final_pvld && p7_skid_ready_flop && !p7_skid_pipe_ready;  
  p7_skid_ready = (p7_skid_valid)? p7_skid_pipe_ready : !p7_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p7_skid_valid <= 1'b0;
    p7_skid_ready_flop <= 1'b1;
    tru_final_prdy <= 1'b1;
  end else begin
  p7_skid_valid <= (p7_skid_valid)? !p7_skid_pipe_ready : p7_skid_catch;
  p7_skid_ready_flop <= p7_skid_ready;
  tru_final_prdy <= p7_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p7_skid_data <= (p7_skid_catch)? chn_dout[17:0] : p7_skid_data;
  // VCS sop_coverage_off end
end
always @(
  p7_skid_ready_flop
  or tru_final_pvld
  or p7_skid_valid
  or chn_dout
  or p7_skid_data
  ) begin
  p7_skid_pipe_valid = (p7_skid_ready_flop)? tru_final_pvld : p7_skid_valid; 
  // VCS sop_coverage_off start
  p7_skid_pipe_data = (p7_skid_ready_flop)? chn_dout[17:0] : p7_skid_data;
  // VCS sop_coverage_off end
end
//## pipe (7) valid-ready-bubble-collapse
always @(
  p7_pipe_ready
  or p7_pipe_valid
  ) begin
  p7_pipe_ready_bc = p7_pipe_ready || !p7_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p7_pipe_valid <= 1'b0;
  end else begin
  p7_pipe_valid <= (p7_pipe_ready_bc)? p7_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p7_pipe_data <= (p7_pipe_ready_bc && p7_skid_pipe_valid)? p7_skid_pipe_data : p7_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p7_pipe_ready_bc
  ) begin
  p7_skid_pipe_ready = p7_pipe_ready_bc;
end
//## pipe (7) output
always @(
  p7_pipe_valid
  or chn_out_prdy
  or p7_pipe_data
  ) begin
  chn_out_pvld = p7_pipe_valid;
  p7_pipe_ready = chn_out_prdy;
  chn_data_out[17:0] = p7_pipe_data;
end
//## pipe (7) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p7_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_13x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (chn_out_pvld^chn_out_prdy^tru_final_pvld^tru_final_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_14x (nvdla_core_clk, `ASSERT_RESET, (tru_final_pvld && !tru_final_prdy), (tru_final_pvld), (tru_final_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
