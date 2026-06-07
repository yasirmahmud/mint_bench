module NV_NVDLA_RT_SDP2NOCIF_pipe_p4 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,sdp_b2mcif_rd_req_src_pd_d0
  ,sdp_b2mcif_rd_req_src_ready_d1
  ,sdp_b2mcif_rd_req_src_valid_d0
  ,sdp_b2mcif_rd_req_src_pd_d1
  ,sdp_b2mcif_rd_req_src_ready_d0
  ,sdp_b2mcif_rd_req_src_valid_d1
  );
input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [78:0] sdp_b2mcif_rd_req_src_pd_d0;
input         sdp_b2mcif_rd_req_src_ready_d1;
input         sdp_b2mcif_rd_req_src_valid_d0;
output [78:0] sdp_b2mcif_rd_req_src_pd_d1;
output        sdp_b2mcif_rd_req_src_ready_d0;
output        sdp_b2mcif_rd_req_src_valid_d1;
reg    [78:0] p4_pipe_data;
reg           p4_pipe_ready;
reg           p4_pipe_ready_bc;
reg           p4_pipe_valid;
reg    [78:0] sdp_b2mcif_rd_req_src_pd_d1;
reg           sdp_b2mcif_rd_req_src_ready_d0;
reg           sdp_b2mcif_rd_req_src_valid_d1;
//## pipe (4) valid-ready-bubble-collapse
always @(
  p4_pipe_ready
  or p4_pipe_valid
  ) begin
  p4_pipe_ready_bc = p4_pipe_ready || !p4_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p4_pipe_valid <= 1'b0;
  end else begin
  p4_pipe_valid <= (p4_pipe_ready_bc)? sdp_b2mcif_rd_req_src_valid_d0 : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p4_pipe_data <= (p4_pipe_ready_bc && sdp_b2mcif_rd_req_src_valid_d0)? sdp_b2mcif_rd_req_src_pd_d0[78:0] : p4_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p4_pipe_ready_bc
  ) begin
  sdp_b2mcif_rd_req_src_ready_d0 = p4_pipe_ready_bc;
end
//## pipe (4) output
always @(
  p4_pipe_valid
  or sdp_b2mcif_rd_req_src_ready_d1
  or p4_pipe_data
  ) begin
  sdp_b2mcif_rd_req_src_valid_d1 = p4_pipe_valid;
  p4_pipe_ready = sdp_b2mcif_rd_req_src_ready_d1;
  sdp_b2mcif_rd_req_src_pd_d1[78:0] = p4_pipe_data;
end
//## pipe (4) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p4_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_7x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (sdp_b2mcif_rd_req_src_valid_d1^sdp_b2mcif_rd_req_src_ready_d1^sdp_b2mcif_rd_req_src_valid_d0^sdp_b2mcif_rd_req_src_ready_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_8x (nvdla_core_clk, `ASSERT_RESET, (sdp_b2mcif_rd_req_src_valid_d0 && !sdp_b2mcif_rd_req_src_ready_d0), (sdp_b2mcif_rd_req_src_valid_d0), (sdp_b2mcif_rd_req_src_ready_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
