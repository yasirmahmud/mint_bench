// Specific pipe module definitions, using the generic pipe_data/pipe_flow
module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p1 (
   input nvdla_core_clk
  ,input nvdla_core_rstn
  ,input  [70:0] flow_pd
  ,input  inp_in_pvld
  ,output inp_in_frdy
  ,output [70:0] flow_pd_reg
  ,output xsub_pvld
  ,input  xsub_prdy
  );
  NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_data #(.WIDTH(71)) i_pipe (
     .nvdla_core_clk  (nvdla_core_clk)
    ,.nvdla_core_rstn (nvdla_core_rstn)
    ,.data_in         (flow_pd)
    ,.in_pvld         (inp_in_pvld)
    ,.in_prdy         (inp_in_frdy)
    ,.data_out        (flow_pd_reg)
    ,.out_pvld        (xsub_pvld)
    ,.out_prdy        (xsub_prdy)
    );
endmodule
