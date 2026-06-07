module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p6 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  [52:0] intp_sum
  ,input  sum_in_pvld
  ,input  sum_out_prdy
  ,output [52:0] intp_sum_reg
  ,output sum_in_prdy
  ,output sum_out_pvld
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_data #(.WIDTH(53)) i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.data_in         (intp_sum)
    ,.in_pvld         (sum_in_pvld)
    ,.in_prdy         (sum_in_prdy)
    ,.data_out        (intp_sum_reg)
    ,.out_pvld        (sum_out_pvld)
    ,.out_prdy        (sum_out_prdy)
    );
endmodule
