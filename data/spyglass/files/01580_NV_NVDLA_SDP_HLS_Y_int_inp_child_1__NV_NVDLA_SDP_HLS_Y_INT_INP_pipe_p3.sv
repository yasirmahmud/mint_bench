module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p3 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  [32:0] inp_y0_sum
  ,input  mul_scale_pvld
  ,output mul_scale_prdy
  ,output inp_fout_pvld
  ,input  inp_out_prdy
  ,output [32:0] inp_y0_sum_reg
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_data #(.WIDTH(33)) i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.data_in         (inp_y0_sum)
    ,.in_pvld         (mul_scale_pvld)
    ,.in_prdy         (mul_scale_prdy)
    ,.data_out        (inp_y0_sum_reg)
    ,.out_pvld        (inp_fout_pvld)
    ,.out_prdy        (inp_out_prdy)
    );
endmodule
