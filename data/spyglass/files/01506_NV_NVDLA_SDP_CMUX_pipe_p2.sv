module NV_NVDLA_SDP_CMUX_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,cmux2dp_pd
  ,cmux2dp_pvld
  ,sdp_cmux2dp_ready
  ,cmux2dp_prdy
  ,sdp_cmux2dp_pd
  ,sdp_cmux2dp_valid
  );
input          nvdla_core_clk;
input          nvdla_core_rstn;
input  [511:0] cmux2dp_pd;
input          cmux2dp_pvld;
input          sdp_cmux2dp_ready;
output         cmux2dp_prdy;
output [511:0] sdp_cmux2dp_pd;
output         sdp_cmux2dp_valid;
reg            cmux2dp_prdy;
reg    [511:0] p2_pipe_data;
reg    [511:0] p2_pipe_rand_data;
reg            p2_pipe_rand_ready;
reg            p2_pipe_rand_valid;
reg            p2_pipe_ready;
reg            p2_pipe_ready_bc;
reg            p2_pipe_valid;
reg            p2_skid_catch;
reg    [511:0] p2_skid_data;
reg    [511:0] p2_skid_pipe_data;
reg            p2_skid_pipe_ready;
reg            p2_skid_pipe_valid;
reg            p2_skid_ready;
reg            p2_skid_ready_flop;
reg            p2_skid_valid;
reg    [511:0] sdp_cmux2dp_pd;
reg            sdp_cmux2dp_valid;
//## pipe (2) randomizer
`ifndef SYNTHESIS
reg p2_pipe_rand_active;
`endif
always @(
  `ifndef SYNTHESIS
  p2_pipe_rand_active
  or 
     `endif
     cmux2dp_pvld
  or p2_pipe_rand_ready
  or cmux2dp_pd
  ) begin
  `ifdef SYNTHESIS
  p2_pipe_rand_valid = cmux2dp_pvld;
  cmux2dp_prdy = p2_pipe_rand_ready;
  p2_pipe_rand_data = cmux2dp_pd[511:0];
  `else
  // VCS coverage off
  p2_pipe_rand_valid = (p2_pipe_rand_active)? 1'b0 : cmux2dp_pvld;
  cmux2dp_prdy = (p2_pipe_rand_active)? 1'b0 : p2_pipe_rand_ready;
  p2_pipe_rand_data = (p2_pipe_rand_active)?  'bx : cmux2dp_pd[511:0];
  // VCS coverage on
  `endif
end
`ifndef SYNTHESIS
// VCS coverage off
//// randomization init   
integer p2_pipe_stall_cycles;
integer p2_pipe_stall_probability;
integer p2_pipe_stall_cycles_min;
integer p2_pipe_stall_cycles_max;
initial begin
  p2_pipe_stall_cycles = 0;
  p2_pipe_stall_probability = 0;
  p2_pipe_stall_cycles_min = 1;
  p2_pipe_stall_cycles_max = 10;
`ifndef SYNTH_LEVEL1_COMPILE
  if      ( $value$plusargs( "NV_NVDLA_SDP_cmux_pipe_rand_probability=%d",  p2_pipe_stall_probability ) ) ; // deprecated
  else if ( $value$plusargs(    "default_pipe_rand_probability=%d",  p2_pipe_stall_probability ) ) ; // deprecated
  if      ( $value$plusargs( "NV_NVDLA_SDP_cmux_pipe_stall_probability=%d", p2_pipe_stall_probability ) ) ; 
  else if ( $value$plusargs(    "default_pipe_stall_probability=%d", p2_pipe_stall_probability ) ) ; 
  if      ( $value$plusargs( "NV_NVDLA_SDP_cmux_pipe_stall_cycles_min=%d",  p2_pipe_stall_cycles_min  ) ) ;
  else if ( $value$plusargs(    "default_pipe_stall_cycles_min=%d",  p2_pipe_stall_cycles_min  ) ) ;
  if      ( $value$plusargs( "NV_NVDLA_SDP_cmux_pipe_stall_cycles_max=%d",  p2_pipe_stall_cycles_max  ) ) ;
  else if ( $value$plusargs(    "default_pipe_stall_cycles_max=%d",  p2_pipe_stall_cycles_max  ) ) ;
`endif
end
// randomization globals
`ifndef SYNTH_LEVEL1_COMPILE
`ifdef SIMTOP_RANDOMIZE_STALLS
always @( `SIMTOP_RANDOMIZE_STALLS.global_stall_event ) begin
  if ( ! $test$plusargs( "NV_NVDLA_SDP_cmux_pipe_stall_probability" ) ) p2_pipe_stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_probability;
  if ( ! $test$plusargs( "NV_NVDLA_SDP_cmux_pipe_stall_cycles_min"  ) ) p2_pipe_stall_cycles_min  = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_min;
  if ( ! $test$plusargs( "NV_NVDLA_SDP_cmux_pipe_stall_cycles_max"  ) ) p2_pipe_stall_cycles_max  = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_max;
end
`endif
`endif
//// randomization active
reg p2_pipe_rand_enable;
reg p2_pipe_rand_poised;
always @(
  p2_pipe_stall_cycles
  or p2_pipe_stall_probability
  or cmux2dp_pvld
  ) begin
  p2_pipe_rand_active = p2_pipe_stall_cycles != 0;
  p2_pipe_rand_enable = p2_pipe_stall_probability != 0;
  p2_pipe_rand_poised = p2_pipe_rand_enable && !p2_pipe_rand_active && cmux2dp_pvld === 1'b1;
end
//// randomization cycles
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p2_pipe_stall_cycles <= 1'b0;
  end else begin
  if (p2_pipe_rand_poised) begin
    if (p2_pipe_stall_probability >= prand_inst0(1, 100)) begin
      p2_pipe_stall_cycles <= prand_inst1(p2_pipe_stall_cycles_min, p2_pipe_stall_cycles_max);
    end
  end else if (p2_pipe_rand_active) begin
    p2_pipe_stall_cycles <= p2_pipe_stall_cycles - 1;
  end else begin
    p2_pipe_stall_cycles <= 0;
  end
  end
end

`ifdef SYNTH_LEVEL1_COMPILE
`else
`ifdef SYNTHESIS
`else
`ifdef PRAND_VERILOG
// Only verilog needs any local variables
reg [47:0] prand_local_seed0;
reg prand_initialized0;
reg prand_no_rollpli0;
`endif
`endif
`endif

function [31:0] prand_inst0;
//VCS coverage off
    input [31:0] min;
    input [31:0] max;
    reg [32:0] diff;
    
    begin
`ifdef SYNTH_LEVEL1_COMPILE
        prand_inst0 = min;
`else
`ifdef SYNTHESIS
        prand_inst0 = min;
`else
`ifdef PRAND_VERILOG
        if (prand_initialized0 !== 1'b1) begin
            prand_no_rollpli0 = $test$plusargs("NO_ROLLPLI");
            if (!prand_no_rollpli0)
                prand_local_seed0 = {$prand_get_seed(0), 16'b0};
            prand_initialized0 = 1'b1;
        end
        if (prand_no_rollpli0) begin
            prand_inst0 = min;
        end else begin
            diff = max - min + 1;
            prand_inst0 = min + prand_local_seed0[47:16] % diff;
            // magic numbers taken from Java's random class (same as lrand48)
            prand_local_seed0 = prand_local_seed0 * 48'h5deece66d + 48'd11;
        end
`else
`ifdef PRAND_OFF
        prand_inst0 = min;
`else
        prand_inst0 = $RollPLI(min, max, "auto");
`endif
`endif
`endif
`endif
    end
//VCS coverage on
endfunction


`ifdef SYNTH_LEVEL1_COMPILE
`else
`ifdef SYNTHESIS
`else
`ifdef PRAND_VERILOG
// Only verilog needs any local variables
reg [47:0] prand_local_seed1;
reg prand_initialized1;
reg prand_no_rollpli1;
`endif
`endif
`endif

function [31:0] prand_inst1;
//VCS coverage off
    input [31:0] min;
    input [31:0] max;
    reg [32:0] diff;
    
    begin
`ifdef SYNTH_LEVEL1_COMPILE
        prand_inst1 = min;
`else
`ifdef SYNTHESIS
        prand_inst1 = min;
`else
`ifdef PRAND_VERILOG
        if (prand_initialized1 !== 1'b1) begin
            prand_no_rollpli1 = $test$plusargs("NO_ROLLPLI");
            if (!prand_no_rollpli1)
                prand_local_seed1 = {$prand_get_seed(1), 16'b0};
            prand_initialized1 = 1'b1;
        end
        if (prand_no_rollpli1) begin
            prand_inst1 = min;
        end else begin
            diff = max - min + 1;
            prand_inst1 = min + prand_local_seed1[47:16] % diff;
            // magic numbers taken from Java's random class (same as lrand48)
            prand_local_seed1 = prand_local_seed1 * 48'h5deece66d + 48'd11;
        end
`else
`ifdef PRAND_OFF
        prand_inst1 = min;
`else
        prand_inst1 = $RollPLI(min, max, "auto");
`endif
`endif
`endif
`endif
    end
//VCS coverage on
endfunction

`endif
// VCS coverage on
//## pipe (2) skid buffer
always @(
  p2_pipe_rand_valid
  or p2_skid_ready_flop
  or p2_skid_pipe_ready
  or p2_skid_valid
  ) begin
  p2_skid_catch = p2_pipe_rand_valid && p2_skid_ready_flop && !p2_skid_pipe_ready;  
  p2_skid_ready = (p2_skid_valid)? p2_skid_pipe_ready : !p2_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p2_skid_valid <= 1'b0;
    p2_skid_ready_flop <= 1'b1;
    p2_pipe_rand_ready <= 1'b1;
  end else begin
  p2_skid_valid <= (p2_skid_valid)? !p2_skid_pipe_ready : p2_skid_catch;
  p2_skid_ready_flop <= p2_skid_ready;
  p2_pipe_rand_ready <= p2_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p2_skid_data <= (p2_skid_catch)? p2_pipe_rand_data : p2_skid_data;
  // VCS sop_coverage_off end
end
always @(
  p2_skid_ready_flop
  or p2_pipe_rand_valid
  or p2_skid_valid
  or p2_pipe_rand_data
  or p2_skid_data
  ) begin
  p2_skid_pipe_valid = (p2_skid_ready_flop)? p2_pipe_rand_valid : p2_skid_valid; 
  // VCS sop_coverage_off start
  p2_skid_pipe_data = (p2_skid_ready_flop)? p2_pipe_rand_data : p2_skid_data;
  // VCS sop_coverage_off end
end
//## pipe (2) valid-ready-bubble-collapse
always @(
  p2_pipe_ready
  or p2_pipe_valid
  ) begin
  p2_pipe_ready_bc = p2_pipe_ready || !p2_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p2_pipe_valid <= 1'b0;
  end else begin
  p2_pipe_valid <= (p2_pipe_ready_bc)? p2_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
  // VCS sop_coverage_off start
  p2_pipe_data <= (p2_pipe_ready_bc && p2_skid_pipe_valid)? p2_skid_pipe_data : p2_pipe_data;
  // VCS sop_coverage_off end
end
always @(
  p2_pipe_ready_bc
  ) begin
  p2_skid_pipe_ready = p2_pipe_ready_bc;
end
//## pipe (2) output
always @(
  p2_pipe_valid
  or sdp_cmux2dp_ready
  or p2_pipe_data
  ) begin
  sdp_cmux2dp_valid = p2_pipe_valid;
  p2_pipe_ready = sdp_cmux2dp_ready;
  sdp_cmux2dp_pd = p2_pipe_data;
end
//## pipe (2) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p2_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (sdp_cmux2dp_valid^sdp_cmux2dp_ready^cmux2dp_pvld^cmux2dp_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready")      zzz_assert_hold_throughout_event_interval_4x (nvdla_core_clk, `ASSERT_RESET, (cmux2dp_pvld && !cmux2dp_prdy), (cmux2dp_pvld), (cmux2dp_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
