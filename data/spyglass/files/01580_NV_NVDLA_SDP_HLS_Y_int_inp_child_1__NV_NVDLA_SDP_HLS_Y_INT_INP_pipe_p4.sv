module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p4 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  inp_in_pvld
  ,output inp_in_prdy0
  ,input  [52:0] mul0
  ,input  mul0_prdy
  ,output mul0_pvld
  ,output [52:0] mul0_reg
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_data #(.WIDTH(53)) i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.data_in         (mul0)
    ,.in_pvld         (inp_in_pvld)
    ,.in_prdy         (inp_in_prdy0)
    ,.data_out        (mul0_reg)
    ,.out_pvld        (mul0_pvld)
    ,.out_prdy        (mul0_prdy)
    );
endmodule
