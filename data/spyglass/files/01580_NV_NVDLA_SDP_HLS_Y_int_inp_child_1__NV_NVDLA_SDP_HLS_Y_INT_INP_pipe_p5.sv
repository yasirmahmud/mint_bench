module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p5 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  inp_in_pvld
  ,output inp_in_prdy1
  ,input  [52:0] mul1
  ,input  mul1_prdy
  ,output mul1_pvld
  ,output [52:0] mul1_reg
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_data #(.WIDTH(53)) i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.data_in         (mul1)
    ,.in_pvld         (inp_in_pvld)
    ,.in_prdy         (inp_in_prdy1)
    ,.data_out        (mul1_reg)
    ,.out_pvld        (mul1_pvld)
    ,.out_prdy        (mul1_prdy)
    );
endmodule
