module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p9 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  flow_in_pipe1
  ,input  flow_pipe1_pvld
  ,input  flow_pipe2_prdy
  ,output flow_in_pipe2
  ,output flow_pipe1_prdy
  ,output flow_pipe2_pvld
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_flow i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.in_data         (flow_in_pipe1)
    ,.in_pvld         (flow_pipe1_pvld)
    ,.in_prdy         (flow_pipe1_prdy)
    ,.out_data        (flow_in_pipe2)
    ,.out_pvld        (flow_pipe2_pvld)
    ,.out_prdy        (flow_pipe2_prdy)
    );
endmodule
