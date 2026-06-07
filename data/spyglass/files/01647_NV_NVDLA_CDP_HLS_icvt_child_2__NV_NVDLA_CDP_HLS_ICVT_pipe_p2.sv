// NV_NVDLA_CDP_HLS_ICVT_pipe_p2 definition
module NV_NVDLA_CDP_HLS_ICVT_pipe_p2 (
   input             nvdla_core_clk
  ,input             nvdla_core_rstn
  ,input  [24:0]     mul_lsb_dout
  ,input  [24:0]     mul_msb_dout
  ,input             mul_outh_prdy
  ,input             sub_outh_pvld // This is the 'in_pvld' for this stage
  ,output      [24:0] mul_lsb_data_out // Changed from 'output reg' to 'output wire' to fix STX_VE_362
  ,output      [24:0] mul_msb_data_out // Changed from 'output reg' to 'output wire' to fix STX_VE_362
  ,output            mul_outh_pvld
  ,output            sub_outh_prdy // This is the 'in_prdy' for this stage
  );

  reg  sub_outh_pvld_q;
  reg  [24:0] mul_lsb_dout_q;
  reg  [24:0] mul_msb_dout_q;

  assign sub_outh_prdy = (!sub_outh_pvld_q) || mul_outh_prdy;
  assign mul_outh_pvld = sub_outh_pvld_q;

  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      sub_outh_pvld_q <= 1'b0;
      mul_lsb_dout_q  <= 25'b0;
      mul_msb_dout_q  <= 25'b0;
    end else begin
      if (sub_outh_pvld && sub_outh_prdy) begin // Capture input
        mul_lsb_dout_q  <= mul_lsb_dout;
        mul_msb_dout_q  <= mul_msb_dout;
        sub_outh_pvld_q <= 1'b1;
      end else if (sub_outh_pvld_q && mul_outh_prdy) begin // Output taken
        sub_outh_pvld_q <= 1'b0;
      end
    end
  end

  assign mul_lsb_data_out = mul_lsb_dout_q;
  assign mul_msb_data_out = mul_msb_dout_q;

endmodule
