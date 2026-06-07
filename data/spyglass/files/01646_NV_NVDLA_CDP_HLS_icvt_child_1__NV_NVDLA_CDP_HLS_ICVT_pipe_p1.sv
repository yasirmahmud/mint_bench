// NV_NVDLA_CDP_HLS_ICVT_pipe_p1 definition
module NV_NVDLA_CDP_HLS_ICVT_pipe_p1 (
   input             nvdla_core_clk
  ,input             nvdla_core_rstn
  ,input             chn_int8_pvld
  ,input  [8:0]      sub_lsb_dout
  ,input  [8:0]      sub_msb_dout
  ,input             sub_outh_prdy
  ,output            chn_int8_prdy
  ,output reg [8:0]  sub_lsb_data_out
  ,output reg [8:0]  sub_msb_data_out
  ,output            sub_outh_pvld
  );

  reg  chn_int8_pvld_q;
  reg  [8:0] sub_lsb_dout_q;
  reg  [8:0] sub_msb_dout_q;

  assign chn_int8_prdy = (!chn_int8_pvld_q) || sub_outh_prdy;
  assign sub_outh_pvld = chn_int8_pvld_q;

  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      chn_int8_pvld_q  <= 1'b0;
      sub_lsb_dout_q   <= 9'b0;
      sub_msb_dout_q   <= 9'b0;
    end else begin
      if (chn_int8_pvld && chn_int8_prdy) begin // Capture input
        sub_lsb_dout_q   <= sub_lsb_dout;
        sub_msb_dout_q   <= sub_msb_dout;
        chn_int8_pvld_q  <= 1'b1;
      end else if (chn_int8_pvld_q && sub_outh_prdy) begin // Output taken
        chn_int8_pvld_q  <= 1'b0;
      end
    end
  end

  assign sub_lsb_data_out = sub_lsb_dout_q;
  assign sub_msb_data_out = sub_msb_dout_q;

endmodule
