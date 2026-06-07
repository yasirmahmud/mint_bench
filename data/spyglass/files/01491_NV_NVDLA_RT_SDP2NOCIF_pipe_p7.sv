module NV_NVDLA_RT_SDP2NOCIF_pipe_p7 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mcif2sdp_rd_rsp_src_pd_d0
  ,mcif2sdp_rd_rsp_src_ready_d1
  ,mcif2sdp_rd_rsp_src_valid_d0
  ,mcif2sdp_rd_rsp_src_pd_d1
  ,mcif2sdp_rd_rsp_src_ready_d0
  ,mcif2sdp_rd_rsp_src_valid_d1
  );
input          nvdla_core_clk;
input          nvdla_core_rstn;
input  [513:0] mcif2sdp_rd_rsp_src_pd_d0;
input          mcif2sdp_rd_rsp_src_ready_d1;
input          mcif2sdp_rd_rsp_src_valid_d0;
output [513:0] mcif2sdp_rd_rsp_src_pd_d1;
output         mcif2sdp_rd_rsp_src_ready_d0;
output         mcif2sdp_rd_rsp_src_valid_d1;
reg    [513:0] mcif2sdp_rd_rsp_src_pd_d1;
reg            mcif2sdp_rd_rsp_src_ready_d0;
reg            mcif2sdp_rd_rsp_src_valid_d1;
reg    [513:0] p7_pipe_data;
reg            p7_pipe_ready;
reg            p7_pipe_ready_bc;
reg            p7_pipe_valid;
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
  p7_pipe_valid <= (p7_pipe_ready_bc)? mcif2sdp_rd_rsp_src_valid_d0 : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p7_pipe_data <= (p7_pipe_ready_bc && mcif2sdp_rd_rsp_src_valid_d0)? mcif2sdp_rd_rsp_src_pd_d0[513:0] : p7_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p7_pipe_ready_bc
  ) begin
  mcif2sdp_rd_rsp_src_ready_d0 = p7_pipe_ready_bc;
end
//## pipe (7) output
always @(
  p7_pipe_valid
  or mcif2sdp_rd_rsp_src_ready_d1
  or p7_pipe_data
  ) begin
  mcif2sdp_rd_rsp_src_valid_d1 = p7_pipe_valid;
  p7_pipe_ready = mcif2sdp_rd_rsp_src_ready_d1;
  mcif2sdp_rd_rsp_src_pd_d1[513:0] = p7_pipe_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_13x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mcif2sdp_rd_rsp_src_valid_d1^mcif2sdp_rd_rsp_src_ready_d1^mcif2sdp_rd_rsp_src_valid_d0^mcif2sdp_rd_rsp_src_ready_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_14x (nvdla_core_clk, `ASSERT_RESET, (mcif2sdp_rd_rsp_src_valid_d0 && !mcif2sdp_rd_rsp_src_ready_d0), (mcif2sdp_rd_rsp_src_valid_d0), (mcif2sdp_rd_rsp_src_ready_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
