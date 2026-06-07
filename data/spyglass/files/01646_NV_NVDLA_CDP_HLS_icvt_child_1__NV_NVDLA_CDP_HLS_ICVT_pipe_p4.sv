// NV_NVDLA_CDP_HLS_ICVT_pipe_p4 definition
module NV_NVDLA_CDP_HLS_ICVT_pipe_p4 (
   input             nvdla_core_clk
  ,input             nvdla_core_rstn
  ,input             chn_int16_pvld
  ,input  [16:0]     sub_dout
  ,input             sub_out_prdy
  ,output            chn_int16_prdy
  ,output reg [16:0] sub_data_out
  ,output            sub_out_pvld
  );

  reg  chn_int16_pvld_q;
  reg  [16:0] sub_dout_q;

  assign chn_int16_prdy = (!chn_int16_pvld_q) || sub_out_prdy;
  assign sub_out_pvld   = chn_int16_pvld_q;

  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      chn_int16_pvld_q <= 1'b0;
      sub_dout_q       <= 17'b0;
    end else begin
      if (chn_int16_pvld && chn_int16_prdy) begin // Capture input
        sub_dout_q       <= sub_dout;
        chn_int16_pvld_q <= 1'b1;
      end else if (chn_int16_pvld_q && sub_out_prdy) begin // Output taken
        chn_int16_pvld_q <= 1'b0;
      end
    end
  end

  assign sub_data_out = sub_dout_q;

endmodule
