// NV_NVDLA_CDP_HLS_ICVT_pipe_p3 definition
module NV_NVDLA_CDP_HLS_ICVT_pipe_p3 (
   input             nvdla_core_clk
  ,input             nvdla_core_rstn
  ,input             mul_outh_pvld // This is the 'in_pvld' for this stage
  ,input  [8:0]      tru_lsb_dout
  ,input  [8:0]      tru_msb_dout
  ,input             tru_outh_prdy
  ,output            mul_outh_prdy // This is the 'in_prdy' for this stage
  ,output      [8:0]  tru_lsb_data_out // Changed from 'output reg' to 'output wire' to fix STX_VE_362
  ,output      [8:0]  tru_msb_data_out // Changed from 'output reg' to 'output wire' to fix STX_VE_362
  ,output            tru_outh_pvld
  );

  reg  mul_outh_pvld_q;
  reg  [8:0] tru_lsb_dout_q;
  reg  [8:0] tru_msb_dout_q;

  assign mul_outh_prdy = (!mul_outh_pvld_q) || tru_outh_prdy;
  assign tru_outh_pvld = mul_outh_pvld_q;

  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      mul_outh_pvld_q <= 1'b0;
      tru_lsb_dout_q  <= 9'b0;
      tru_msb_dout_q  <= 9'b0;
    end else begin
      if (mul_outh_pvld && mul_outh_prdy) begin // Capture input
        tru_lsb_dout_q  <= tru_lsb_dout;
        tru_msb_dout_q  <= tru_msb_dout;
        mul_outh_pvld_q <= 1'b1;
      end else if (mul_outh_pvld_q && tru_outh_prdy) begin // Output taken
        mul_outh_pvld_q <= 1'b0;
      end
    end
  end

  assign tru_lsb_data_out = tru_lsb_dout_q;
  assign tru_msb_data_out = tru_msb_dout_q;

endmodule
