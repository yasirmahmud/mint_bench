// NV_NVDLA_CDP_HLS_ICVT_pipe_p6 definition
module NV_NVDLA_CDP_HLS_ICVT_pipe_p6 (
   input             nvdla_core_clk
  ,input             nvdla_core_rstn
  ,input             mul_out_pvld // This is the 'in_pvld' for this stage
  ,input  [16:0]     tru_dout
  ,input             tru_out_prdy
  ,output            mul_out_prdy // This is the 'in_prdy' for this stage
  ,output reg [16:0] tru_data_out
  ,output            tru_out_pvld
  );

  reg  mul_out_pvld_q;
  reg  [16:0] tru_dout_q;

  assign mul_out_prdy = (!mul_out_pvld_q) || tru_out_prdy;
  assign tru_out_pvld = mul_out_pvld_q;

  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      mul_out_pvld_q <= 1'b0;
      tru_dout_q     <= 17'b0;
    end else begin
      if (mul_out_pvld && mul_out_prdy) begin // Capture input
        tru_dout_q     <= tru_dout;
        mul_out_pvld_q <= 1'b1;
      end else if (mul_out_pvld_q && tru_out_prdy) begin // Output taken
        mul_out_pvld_q <= 1'b0;
      end
    end
  end

  assign tru_data_out = tru_dout_q;

endmodule
