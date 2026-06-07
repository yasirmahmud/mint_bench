// Dummy module definition for NV_NVDLA_SDP_HLS_X_INT_MUL_pipe_p1
module NV_NVDLA_SDP_HLS_X_INT_MUL_pipe_p1 (
    input                 nvdla_core_clk,
    input                 nvdla_core_rstn,
    input                 bypass_trt,
    input                 mul_final_prdy,
    input  [48:0]         mul_prelu_out,
    input                 mul_sync_pvld,
    output                bypass_trt_reg,
    output [48:0]         mul_data_final,
    output                mul_final_pvld,
    output                mul_sync_prdy
);
    // Simple wire passthrough for linting purposes
    assign bypass_trt_reg = bypass_trt;
    assign mul_data_final = mul_prelu_out;
    assign mul_final_pvld = mul_sync_pvld;
    assign mul_sync_prdy  = mul_final_prdy;
endmodule
