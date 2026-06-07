module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p2 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  [70:0] flow_pd2
  ,input  mul_scale_prdy
  ,input  xsub_pvld
  ,output [70:0] flow_pd2_reg
  ,output mul_scale_pvld
  ,output xsub_prdy
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_data #(.WIDTH(71)) i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.data_in         (flow_pd2)
    ,.in_pvld         (xsub_pvld)
    ,.in_prdy         (xsub_prdy)
    ,.data_out        (flow_pd2_reg)
    ,.out_pvld        (mul_scale_pvld)
    ,.out_prdy        (mul_scale_prdy)
    );
endmodule
