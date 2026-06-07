module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p7 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  [31:0] intp_sum_tru
  ,input  sum_out_pvld
  ,output sum_out_prdy
  ,output inp_mout_pvld
  ,input  inp_out_prdy
  ,output [31:0] inp_nrm_dout
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_data #(.WIDTH(32)) i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.data_in         (intp_sum_tru)
    ,.in_pvld         (sum_out_pvld)
    ,.in_prdy         (sum_out_prdy)
    ,.data_out        (inp_nrm_dout)
    ,.out_pvld        (inp_mout_pvld)
    ,.out_prdy        (inp_out_prdy)
    );
endmodule
