module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p10 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  flow_in_pipe2
  ,input  flow_pipe2_pvld
  ,input  flow_pipe3_prdy
  ,output flow_in_pipe3
  ,output flow_pipe2_prdy
  ,output flow_pipe3_pvld
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_flow i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.in_data         (flow_in_pipe2)
    ,.in_pvld         (flow_pipe2_pvld)
    ,.in_prdy         (flow_pipe2_prdy)
    ,.out_data        (flow_in_pipe3)
    ,.out_pvld        (flow_pipe3_pvld)
    ,.out_prdy        (flow_pipe3_prdy)
    );
endmodule
