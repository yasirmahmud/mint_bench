// NV_NVDLA_CDP_HLS_ICVT_pipe_p5 definition
module NV_NVDLA_CDP_HLS_ICVT_pipe_p5 (
   input             nvdla_core_clk
  ,input             nvdla_core_rstn
  ,input  [32:0]     mul_dout
  ,input             mul_out_prdy
  ,input             sub_out_pvld // This is the 'in_pvld' for this stage
  ,output      [32:0] mul_data_out // Changed from 'output reg' to 'output wire' to fix STX_VE_362
  ,output            mul_out_pvld
  ,output            sub_out_prdy // This is the 'in_prdy' for this stage
  );

  reg  sub_out_pvld_q;
  reg  [32:0] mul_dout_q;

  assign sub_out_prdy = (!sub_out_pvld_q) || mul_out_prdy;
  assign mul_out_pvld = sub_out_pvld_q;

  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      sub_out_pvld_q <= 1'b0;
      mul_dout_q     <= 33'b0;
    end else begin
      if (sub_out_pvld && sub_out_prdy) begin // Capture input
        mul_dout_q     <= mul_dout;
        sub_out_pvld_q <= 1'b1;
      end else if (sub_out_pvld_q && mul_out_prdy) begin // Output taken
        sub_out_pvld_q <= 1'b0;
      end
    end
  end

  assign mul_data_out = mul_dout_q;

endmodule
