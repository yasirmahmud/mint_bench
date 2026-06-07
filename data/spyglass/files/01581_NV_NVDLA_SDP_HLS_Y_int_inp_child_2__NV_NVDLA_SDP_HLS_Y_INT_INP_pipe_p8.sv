module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p8 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  flow_pipe1_prdy
  ,input  inp_flow_in
  ,input  inp_flow_pvld
  ,output flow_in_pipe1
  ,output inp_flow_prdy
  ,output flow_pipe1_pvld
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_flow i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.in_data         (inp_flow_in)
    ,.in_pvld         (inp_flow_pvld)
    ,.in_prdy         (inp_flow_prdy)
    ,.out_data        (flow_in_pipe1)
    ,.out_pvld        (flow_pipe1_pvld)
    ,.out_prdy        (flow_pipe1_prdy)
    );
endmodule
